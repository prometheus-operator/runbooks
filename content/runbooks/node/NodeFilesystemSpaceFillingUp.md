# NodeFilesystemSpaceFillingUp

## Meaning

This alert is based on an extrapolation of the space used in a file system. It
fires if both the current usage is above a certain threshold _and_ the
extrapolation predicts to run out of space in a certain time. This is a
warning-level alert if that time is less than 24h. It's a critical alert if that
time is less than 4h.

<details>
<summary>Full context</summary>

The filesystem on Kubernetes nodes mainly consists of the operating system, [container ephemeral storage][1], container images, and container logs.
Since Kubelet automatically handles [cleaning up old logs][2] and [deleting unused images][3], container ephemeral storage is a common cause of this alert. Although this alert may be triggered before Kubelet's garbage collection kicks in.

</details>

## Impact

A filesystem running full is very bad for any process in need to write to the
filesystem. But even before a filesystem runs full, performance is usually
degrading.

## Diagnosis

Study the recent trends of filesystem usage on a dashboard. Sometimes a periodic
pattern of writing and cleaning up can trick the linear prediction into a false
alert. Use the usual OS tools to investigate what directories are the worst
and/or recent offenders. Is this some irregular condition, e.g. a process fails
to clean up behind itself or is this organic growth? If monitoring is enabled,
the following metric can be watched in PromQL.

```console
node_filesystem_free_bytes
```

Check the alert's `mountpoint` label.

## Mitigation

For the case that the `mountpoint` label is `/`, `/sysroot` or `/var`; then
removing unused images solves that issue:

Debug the node by accessing the node filesystem:

```console
$ NODE_NAME=<instance label from alert>
$ kubectl -n default debug node/$NODE_NAME
$ chroot /host
```

Remove dangling images:

```console
# TODO: Command needed
```

Remove unused images:

```console
# TODO: Command needed
```

Exit debug:

```console
$ exit
$ exit
```

[1]: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#local-ephemeral-storage
[2]: https://kubernetes.io/docs/concepts/cluster-administration/logging/
[3]: https://kubernetes.io/docs/concepts/architecture/garbage-collection/#containers-images
