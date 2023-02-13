---
title: Kube DaemonSet Rollout Stuck
weight: 20
---

# KubeDaemonSetRolloutStuck

## Meaning

DaemonSet update is stuck waiting for replaced pod.


## Impact

Service degradation or unavailability.

## Diagnosis

- Check daemonset status via `kubectl -n $NAMESPACE describe daemonset $NAME`.
- Check [DaemonSet update strategy](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/)
- Check the status of the pods which belong to the replica sets under the deployment.
- Check pod template parameters such as:
  - pod priority - maybe it was evicted by other more important pods
  - resources - maybe it tries to use unavailable resource, such as GPU but
    there is limited number of nodes with GPU
  - affinity rules - maybe due to affinities and not enough nodes it is not
    possible to schedule pods
  - pod termination grace period - if too long then pods may be for too long
    in terminating state
- Check if Horizontal Pod Autoscaler (HPA) is not triggered due to untested
  values (requests values).
- Check if cluster-autoscaler is able to create new nodes - see its logs or
  cluster-autoscaler status configmap.

## Mitigation

See [DaemonSet rolling update is stuck](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/#daemonset-rolling-update-is-stuck)

In some rare cases you may need to change node affinities or delete pod
manually if this is special daemonset
which has pod priority class system-cluster-critical and is limited to only
1 replica (so it runs on specific node only)

See [Debugging Pods](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods)
