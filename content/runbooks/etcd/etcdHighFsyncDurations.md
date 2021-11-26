# etcdHighFsyncDurations

## Meaning

This alert fires when the 99th percentile of etcd disk fsync duration is too
high for 10 minutes.

## Impact

When this happens it can lead to various scenarios like leader election failure,
frequent leader elections, slow reads and writes.

## Diagnosis

This could be result of slow disk possibly due to fragmented state in etcd or
simply due to slow disk.

### Slow disk

Checking disk related metrics and dashboards should provide a more clear
picture.

#### PromQL queries used to troubleshoot

`etcd_disk_wal_fsync_duration_seconds_bucket` reports the etcd disk fsync
duration, `etcd_server_leader_changes_seen_total` reports the leader changes. To
rule out a slow disk and confirm that the disk is reasonably fast, 99th
percentile of the `etcd_disk_wal_fsync_duration_seconds_bucket` should be less
than 10ms. Query in metrics UI:

```console
histogram_quantile(0.99, sum by (instance, le) (irate(etcd_disk_wal_fsync_duration_seconds_bucket{job="etcd"}[5m])))
```

## Mitigation

### Fragmented state

In the case of slow fisk or when the etcd DB size increases, we can defragment
existing etcd DB to optimize DB consumption as described in
[here][etcdDefragmentation]. Run the following command in all etcd pods.

```console
$ etcdctl defrag
```

As validation, check the endpoint status of etcd members to know the reduced
size of etcd DB. Use for this purpose the same diagnostic approaches as listed
above. More space should be available now.

Further info on etcd best practices can be found in the [OpenShift docs
here][etcdPractices].

[etcdDefragmentation]: https://etcd.io/docs/v3.4.0/op-guide/maintenance/
[etcdPractices]: https://docs.openshift.com/container-platform/4.7/scalability_and_performance/recommended-host-practices.html#recommended-etcd-practices_
