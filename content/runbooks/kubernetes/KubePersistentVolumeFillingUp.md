---
title: Kube Persistent Volume Filling Up
weight: 20
---

# KubePersistentVolumeFillingUp

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

Ask the service owner if specific old data can be deleted.
Enable data retention especially for snapshots, if possible.

### Data export

If data is not needed in the service but needs to be processed later 
then send it to somewhere else, for example to S3 bucket.

### Data rebalance in the cluster

Some services automatically rebalance data on the cluster when one node fills up.
Some allow to rebalance data across existing nodes, the other may require adding new nodes.
If this is supported then increase number of replicas and wait for data migration or trigger it manually.

Example services that support this:

- cassandra
- ceph
- elasticsearch/opensearch
- gluster
- hadoop
- kafka
- minio

**Notice**: some services may require special scaling conditions such as adding twice more nodes than exist now.

### Direct Volume resizing

If volume resizing is available, it's easiest to increase the capacity of the volume.

To check if volume expansion is available, run this with your namespace and PVC-name replaced.

```bash
$ kubectl get storageclass `kubectl -n <my-namespace> get pvc <my-pvc> -ojson | jq -r '.spec.storageClassName'`       
NAME                 PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
standard (default)   kubernetes.io/gce-pd   Delete          Immediate           true                   28d
```

In this case `ALLOWVOLUMEEXPANSION` is true, so we can make use of the feature.

To resize the volume run:

```bash
$ kubectl -n <my-namespace> edit pvc <my-pvc>
```

And edit `.spec.resources.requests.storage` to the new desired storage size. Eventually the PVC status will say "Waiting for user to (re-)start a pod to finish file system resize of volume on node."

You can check this with:

```bash
$ kubectl -n <my-namespace> get pvc <my-pvc>
```

Once the PVC status says to restart the respective pod, run this to restart it (this automatically finds the pod that mounts the PVC and deletes it, if you know the pod name, you can also just simply delete that pod):

```bash
$ kubectl -n <my-namespace> delete pod `kubectl -n <my-namespace> get pod -ojson | jq -r '.items[] | select(.spec.volumes[] .persistentVolumeClaim.claimName=="<my-pvc>") | .metadata.name'`
```

### Migrate data to a new, larger volume

When resizing is not available and the data is not safe to be deleted, then the only way is to create a larger volume and migrate the data.

TODO


### Purge volume

When the data is ephemeral and volume expansion is not available, it may be best to purge the volume.

**WARNING/DANGER**: This will permanently delete the data on the volume. Performing these steps is your responsibility.

TODO

### Migrate data to new, larger instance pool in the same cluster

In very specific scenarios it is better to schedule data migration in the same cluster but to a new instances.
This is sometimes hard to accomplish due to the way how certain resources are managed in kubernetes.

In general procedure is like this:

- add new nodes with bigger capacity than existing cluster
- trigger data migration
- scale in to 0 old instance pool and after that delete it.

### Migrate data to new, larger cluster

This is most common scenario, but is much more expensive and may be a bit time consuming.
Also sometimes this causes split brain issues when writing.

In general procedure is like this, this is only a suggestion, though:

- create data snapshot on existing cluster
- add new cluster with bigger capacity than existing cluster
- start data restore on new cluster based on the snapshot
- switch old cluster to read only mode
- reconfigure networking to point to new cluster
- trigger data migration from old cluster to new cluster to sync difference between snapshot and latest writes
- remove old cluster

