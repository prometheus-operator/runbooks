---
title: Kube DaemonSet Not Scheduled
weight: 20
---

# KubeDaemonSetNotScheduled

## Meaning

A number of pods of daemonset are not scheduled.

## Impact

Service degradation or unavailability.

## Diagnosis

Usually happens when specifying wrong pod taints/affinities or lack of
resources on the nodes.

- Check daemonset status via `kubectl -n $NAMESPACE describe daemonset $NAME`.
- Check [DaemonSet update strategy](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/)
- Check the status of the pods which belong to the replica sets under the deployment.
- Check pod template parameters such as:
  - pod priority - maybe it was evicted by other more important pods
  - resources - maybe it tries to use unavailable resource, such as GPU but
    there is limited number of nodes with GPU
  - affinity rules - maybe due to affinities and not enough nodes it is not
    possible to schedule pods
- Check if Horizontal Pod Autoscaler (HPA) is not triggered due to untested
  values (requests values).
- Check if cluster-autoscaler is able to create new nodes - see its logs or
  cluster-autoscaler status configmap.

## Mitigation

Set proper priority class for important dameonsets to system-node-critical.

See [DaemonSet rolling update is stuck](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/#daemonset-rolling-update-is-stuck)

In some rare cases you may need to change node affinities or delete pod
manually if this is special daemonset which has specific pod priority class
and is limited to only 1 replica (so it runs on specific node only)

See [Debugging Pods](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods)
