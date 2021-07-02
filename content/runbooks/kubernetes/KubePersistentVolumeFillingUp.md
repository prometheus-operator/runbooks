# KubePersistentVolumeFillingUp

There can be various reasons why a volume is filling up. This runbook does not cover application specific reasons, only mitigations for volumes that are legitimately filling.

## Volume resizing

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

## Migrate data to a new, larger volume

When resizing is not available and the data is not safe to be deleted, then the only way is to create a larger volume and migrate the data.

TODO

## Purge volume

When the data is ephemeral and volume expansion is not available, it may be best to purge the volume.

WARNING/DANGER: This will permanently delete the data on the volume. Performing these steps is your responsibility.

TODO
