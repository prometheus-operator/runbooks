---
title: Kube Persistent Volume Inodes Filling Up
weight: 20
---

# KubePersistentVolumeInodesFillingUp

## Meaning

There can be various reasons why a volume is filling up.
This runbook does not cover application specific reasons, only mitigations
for volumes that are legitimately filling.

As always refer to recommended scenarios for given service.

## Impact

Service degradation, switching to read only mode.

## Diagnosis

Check app usage in time.
Check if there are any configurations such as snapshotting, automatic data retention.

## Mitigation

### Data retention

Deleting no longer needed data is the fastest and the cheapest solution.

The inode limit for a specific filesystem is generally proportional to the 
filesystem size, so increasing the PV size is another fast option.

Ask the service owner if specific old data can be deleted.
Enable data retention especially for snapshots, if possible.
Increase the size of the pv.

### Data export

If data is not needed in the service but needs to be processed later 
then send it to somewhere else, for example to S3 bucket.

### Data rebalance in the cluster

Some services automatically rebalance data on the cluster when one node
fills up. 
Some allow to rebalance data across existing nodes, the other may require
adding new nodes.
If this is supported then increase number of replicas and wait for data
migration or trigger it manually.

Example services that support this:

- cassandra
- ceph
- elasticsearch/opensearch
- gluster
- hadoop
- kafka
- minio

**Notice**: some services may require special scaling conditions such as
adding twice more nodes than exist now.

### Direct Volume resizing

If volume resizing is available, it's easiest to increase the capacity of
the volume.

To check if volume expansion is available, run this with your namespace
and PVC-name replaced.

```shell
$ kubectl get storageclass `kubectl -n <my-namespace> get pvc <my-pvc> -ojson | jq -r '.spec.storageClassName'`       
NAME                 PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
standard (default)   kubernetes.io/gce-pd   Delete          Immediate           true                   28d
```

In this case `ALLOWVOLUMEEXPANSION` is true, so we can make use of the feature.

To resize the volume run:

```shell
$ kubectl -n <my-namespace> edit pvc <my-pvc>
```

And edit `.spec.resources.requests.storage` to the new desired storage size.

You can check this with:

```shell
$ kubectl -n <my-namespace> get pvc <my-pvc>
```

### Migrate data to a new, larger volume

When resizing is not available and the data is not safe to be deleted,
then the only way is to create a larger volume and migrate the data.

Another option for inodes is changing the block size, or switching to a
different filesystem format. (i.e. reprovision your pv with xfs instead
of ext4, or change the ext4 formatting option to increase the inode count.)

For most (all?) filesystems dynamically increasing the available inodes is
not possible, and the filesystem needs to be recreated.

### Purge volume

When the data is ephemeral and volume expansion is not available,
it may be best to purge the volume.

**WARNING/DANGER**: This will permanently delete the data on the volume.
Performing these steps is your responsibility.

```bash
$ kubectl -n <my-namespace> delete pvc <my-pvc>
```
