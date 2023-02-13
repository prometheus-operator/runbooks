# etcdInsufficientMembers

## Meaning

This alert fires when there are fewer instances available than are needed by
etcd to be healthy.
This means that etcd cluster has not enough members in the cluster to create quorum.

## Impact

When etcd does not have a majority of instances available the Kubernetes and
OpenShift APIs will reject read and write requests and operations that preserve
the health of workloads cannot be performed.

In general loosing quorum will switch etcd to read only, which effectively renders k8s api read only.
It is possible to read the current state, but not possible to update it.

## Diagnosis

This can occur when multiple control plane nodes are powered off or are unable to
connect to each other via the network. Check that all control plane nodes are
powered on and that network connections between each machine are functional.

Check any other critical, warning or info alerts firing that can assist with the
diagnosis.

Login to the cluster. Check health of master nodes if any of them is in
`NotReady` state or not.

```shell
$ kubectl get nodes -l node-role.kubernetes.io/master=
```

### General etcd health

To run `etcdctl` commands, we need to `exec` into the `etcdctl` container of any
etcd pod.

```shell
$ kubectl exec -c etcdctl -n openshift-etcd $(kubectl get po -l app=etcd -oname -n openshift-etcd | awk -F"/" 'NR==1{ print $2 }')
```

Validate that the `etcdctl` command is available:

```shell
$ etcdctl version
```

Run the following command to get the health of etcd:

```shell
$ etcdctl endpoint health -w table
```

## Mitigation

### Disaster and recovery

If an upgrade is in progress, the alert may automatically resolve in some time
when the master node comes up again. If MCO is not working on the master node,
check the cloud provider to verify if the master node instances are running or not.

In the case when you are running on AWS, the AWS instance retirement might need
a manual reboot of the master node.

As a last resort if none of the above fix the issue and the alert is still
firing, for etcd specific issues follow the steps described in the
[disaster-recovery](https://docs.openshift.com/container-platform/4.7/backup_and_restore/control_plane_backup_and_restore/disaster_recovery/about-disaster-recovery.html).
