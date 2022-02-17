---
title: Kube Deployment Replicas Mismatch
weight: 20
---

# KubeDeploymentReplicasMismatch

## Meaning

Deployment has not matched the expected number of replicas.

<details>
<summary>Full context</summary>

Kubernetes Deployment resource does not have number of replicas which were
declared to be in operation.
For example deployment is expected to have 3 replicas, but it has less than
that for a noticeable period of time.

In rare occasions there may be more replicas than it should and system did
not clean it up.
</details>

## Impact

Service degradation or unavailability.

## Diagnosis

- Check deployment status via `kubectl -n $NAMESPACE describe deployment $NAME`.
- Check how many replicas are there declared.
- Check the status of the pods which belong to the replica sets under the deployment.
- Check pod template parameters such as:
  - pod priority - maybe it was evicted by other more important pods
  - resources - maybe it tries to use unavailable resource, such as GPU
    but there is limited number of nodes with GPU
  - affinity rules - maybe due to affinities and not enough nodes it is
    not possible to schedule pods
  - pod termination grace period - if too long then pods may be for too long
    in terminating state
- Check if Horizontal Pod Autoscaler (HPA) is not triggered due to untested
  values (requests values).
- Check if cluster-autoscaler is able to create new nodes - see its logs or
  cluster-autoscaler status configmap.

## Mitigation

Depending on the conditions usually adding new nodes solves the issue.

Otherwise probably deployment or HPA definition needs to be fixed.

See [Debugging Pods](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods)
