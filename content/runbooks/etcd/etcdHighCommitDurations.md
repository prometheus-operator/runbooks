# etcdHighCommitDurations

## Meaning

This alert fires when the 99th percentile of etcd commit duration is too high
(by default greater than 250ms) for 10 minutes.

<details>
<summary>Full context</summary>

Once a write request is replicated to a quorum of etcd peers via the [Raft
consensus algorithm][raft], the leader "commits" the entry by appending it to
its [boltdb][boltdb] backend (the `db` file) and applies it to its in-memory
state machine. The duration measured by `etcd_disk_backend_commit_duration_seconds`
covers this final fsync of the boltdb file plus the time to apply the entry.

This is distinct from `etcd_disk_wal_fsync_duration_seconds` (covered by
[etcdHighFsyncDurations]({{< ref "etcdHighFsyncDurations" >}})), which
measures only the WAL fsync that happens earlier during replication. A high
commit duration with a healthy WAL fsync time usually points at the boltdb
backend (defragmentation, large DB size) rather than at general disk
slowness.

</details>

## Impact

High commit durations make every write to etcd slower, which directly
translates into slower Kubernetes API server writes (creating/updating/
deleting objects, lease renewals, leader-election locks). Sustained high
values can lead to:

- Slow `kubectl apply` / controller reconciliation.
- Lease renewal failures and spurious leader elections of controllers that
  use the Kubernetes lease API.
- etcd leader changes and, in the worst case, loss of quorum if the leader
  becomes unresponsive long enough to be considered down.

## Diagnosis

### Check disk performance

`etcd_disk_backend_commit_duration_seconds` includes an fsync on the boltdb
file, so the underlying disk has to provide consistently low fsync latency.
The recommended target is a 99th percentile below 25ms (etcd hard-codes
warnings above 100ms and the alert default is 250ms).

#### PromQL queries used to troubleshoot

99th percentile commit duration per instance:

```promql
histogram_quantile(0.99, sum by (instance, le) (rate(etcd_disk_backend_commit_duration_seconds_bucket{job="etcd"}[5m])))
```

Compare with WAL fsync to determine whether the bottleneck is the WAL or the
backend:

```promql
histogram_quantile(0.99, sum by (instance, le) (rate(etcd_disk_wal_fsync_duration_seconds_bucket{job="etcd"}[5m])))
```

Backend DB size and fragmentation:

```promql
etcd_mvcc_db_total_size_in_bytes{job="etcd"}
etcd_mvcc_db_total_size_in_use_in_bytes{job="etcd"}
```

A large gap between `total_size_in_bytes` and `total_size_in_use_in_bytes`
indicates fragmentation that defragmentation can reclaim.

Check leader changes (frequent changes are often a symptom of slow commits):

```promql
increase(etcd_server_leader_changes_seen_total{job="etcd"}[1h])
```

On the affected instance, look at the underlying disk:

```
iostat -xz 2 5
```

Look at the device hosting `--data-dir` (usually `/var/lib/etcd`). High
`%util`, `await` and queue length point at a disk problem.

### Common causes

- Slow / network-attached storage. Etcd requires local SSD/NVMe; NFS, EBS gp2,
  Ceph RBD, etc. typically cannot meet the latency requirement.
- Backend fragmentation after many key churns (especially when running
  Kubernetes events on the same etcd cluster).
- Disk pressure from a noisy neighbour (e.g. logs, container images,
  workloads sharing the disk with etcd).

## Mitigation

### Defragment the backend

If `etcd_mvcc_db_total_size_in_bytes` is much larger than
`etcd_mvcc_db_total_size_in_use_in_bytes`, defragment each member one at a
time as described in the [etcd maintenance guide][etcdDefragmentation]:

```console
$ etcdctl defrag --endpoints=<endpoint>
```

Defragmentation blocks the member, so do it on followers first and on the
leader last (or after a controlled `move-leader`).

### Move etcd to a dedicated fast disk

Etcd should run on a local SSD/NVMe with `fsync` latency well below 10ms.
Move `--data-dir` to a dedicated disk and avoid sharing with the container
runtime, kubelet logs, or workloads.

### Reduce write load

For very large clusters, consider a [separate etcd cluster just for
events][etcd-events], or reduce churn from controllers that write
excessively.

### Tune backend / quota

If the database is hitting the backend quota, raise `--quota-backend-bytes`
(after defragmentation) and watch for `etcdBackendQuotaLowSpace`.

- [raft](https://en.wikipedia.org/wiki/Raft_(algorithm)#Log_replication)
- [boltdb](https://github.com/etcd-io/bbolt)
- [etcd-disks](https://etcd.io/docs/v3.5/op-guide/hardware/#disks)
- [etcd-events](https://github.com/kubernetes/kubernetes/issues/4432)
- [etcdDefragmentation](https://etcd.io/docs/v3.5/op-guide/maintenance/#defragmentation)
