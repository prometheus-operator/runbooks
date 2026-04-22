---
title: Node Disk IO Queue High
weight: 20
---

# NodeDiskIOQueueHigh

## Meaning

The average disk I/O queue length (`aqu-sq`, equivalent to the iostat `aqu-sz`
value, or in Prometheus `rate(node_disk_io_time_weighted_seconds_total[1m])`)
on a block device has been above the warning threshold (typically `10`) for a
sustained period (e.g. 30 minutes). A persistently long request queue means
the kernel is issuing I/O faster than the device can service it.

<details>
<summary>Full context</summary>

`aqu-sq` is the time-weighted average number of I/O requests that were issued
to the device but have not yet completed (in-flight + queued). For most
SATA/SAS disks the hardware queue depth is 32; NVMe devices support up to
1024 per queue. A sustained value of `10` or more on a SATA/SAS disk
typically means the device is approaching saturation and request latency
(`await` / `r_await` / `w_await`) is climbing.

The Prometheus equivalent of `aqu-sq` from `node_exporter` is:

```
rate(node_disk_io_time_weighted_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
```

> NOTE: The blank lines above and below the text inside this `<details>` tag are required to use markdown inside of html tags.

</details>

## Impact

Any process that issues I/O against the affected device experiences higher
latency. Common consequences:

- Slow pod start-up (image pull, volume mount, container fs writes).
- kubelet / container runtime falling behind on writes (logs, cadvisor,
  checkpoints) and possibly being marked `NotReady` if PLEG times out.
- etcd `fsync` / WAL latency spikes if etcd lives on this disk – which can
  trigger leader elections and control-plane unavailability.
- Application-level timeouts for any workload doing synchronous writes
  (databases, message brokers, log shippers).

If the queue keeps growing, requests will eventually time out at the block
layer (`blk_update_request: I/O error`) and filesystems may remount
read-only.

## Diagnosis

Replace `<INSTANCE>` and `<DEVICE>` with the values from the alert labels.

1. Confirm the symptom and identify the device on the affected node:

   ```
   iostat -xz 2 5
   ```

   Look for `aqu-sz` (or `aqu-sq`) above the threshold combined with high
   `%util` (>90%) and rising `r_await` / `w_await`.

2. Find the heaviest writers/readers:

   ```
   sudo iotop -oPa
   sudo pidstat -d 2 5
   ```

3. Check whether the load comes from kernel writeback or a specific
   process. Inspect dirty memory:

   ```
   grep -E 'Dirty|Writeback' /proc/meminfo
   ```

4. From Prometheus, correlate the typical saturation signals over the
   alert window:

   ```
   # Queue length (this alert)
   rate(node_disk_io_time_weighted_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])

   # Utilization (% of time the device was busy)
   rate(node_disk_io_time_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])

   # Average request latency (seconds per op)
   rate(node_disk_read_time_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
     / rate(node_disk_reads_completed_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
   rate(node_disk_write_time_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
     / rate(node_disk_writes_completed_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])

   # IOPS / throughput
   rate(node_disk_reads_completed_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
   rate(node_disk_writes_completed_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
   rate(node_disk_read_bytes_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
   rate(node_disk_written_bytes_total{device="<DEVICE>",instance="<INSTANCE>"}[1m])
   ```

5. Map the device to the Kubernetes workload:

   ```
   lsblk -f
   findmnt /var/lib/kubelet
   findmnt /var/lib/etcd
   findmnt /var/lib/containerd
   crictl ps -a
   ```

   Identify whether the device hosts `/var/lib/etcd`, kubelet pod volumes,
   container image storage, or a PV. Then drain / reschedule the noisy
   workload if appropriate.

6. Check the underlying hardware / virtualization layer. Long queues
   without a corresponding increase in IOPS often indicate degraded media
   (failing SSD, RAID rebuild, noisy neighbour on a shared LUN):

   ```
   sudo smartctl -a /dev/<DEVICE>
   sudo dmesg -T | grep -iE '<DEVICE>|ata|nvme|i/o error'
   ```

## Mitigation

Pick the action(s) appropriate for what diagnosis showed:

- **Noisy pod** – `kubectl cordon` the node and `kubectl drain` (or delete)
  the offending pod so it is rescheduled elsewhere; lower its I/O via
  `requests`/`limits` or cgroup tuning.
- **Backup / batch job** – throttle or reschedule it to off-peak hours
  (e.g. via `ionice -c 3` or job-level rate limiting).
- **etcd on shared disk** – move etcd's data directory to a dedicated fast
  disk; co-locating etcd with general workloads on a saturated spindle is
  unsupported.
- **Failing device** – replace the disk; if it is part of a RAID array let
  the array rebuild during a quiet window.
- **Tuning** – consider switching the I/O scheduler
  (`/sys/block/<DEVICE>/queue/scheduler`) to `mq-deadline` (or `none` for
  NVMe), increasing `nr_requests`, or enabling write caching if disabled.
- **Capacity** – if the workload legitimately needs more IOPS than the
  device can provide, scale horizontally or migrate to faster storage
  (NVMe / SSD / higher-tier cloud volume).

After mitigation, verify the queue length returns below the threshold:

```
rate(node_disk_io_time_weighted_seconds_total{device="<DEVICE>",instance="<INSTANCE>"}[1m]) < 10
```

[1]: https://github.github.com/gfm/#html-block
