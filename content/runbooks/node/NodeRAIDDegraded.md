---
title: Node RAID Degraded
weight: 20
---

# NodeRAIDDegraded

## Meaning

This alert is triggered when a node has a storage configuration with RAID array,
and the array is reporting as being in a degraded state due to one or more disk
failures.

## Impact

The affected node could go offline at any moment if the RAID array fully fails
due to further issues with disks.

## Diagnosis

You can open a shell on the node and use the standard Linux utilities to
diagnose the issue, but you may need to install additional software in the debug
container:

```console
$ NODE_NAME='<value of instance label from alert>'

$ oc debug "node/$NODE_NAME"
$ cat /proc/mdstat
```

## Mitigation

See the Red Hat Enterprise Linux [documentation][1] for potential steps.

[1]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_storage_devices/managing-raid_managing-storage-devices
