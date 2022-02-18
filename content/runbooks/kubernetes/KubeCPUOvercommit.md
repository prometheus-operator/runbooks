---
title: Kube CPU Overcommit
weight: 20
---

# KubeCPUOvercommit

## Meaning

Cluster has overcommitted CPU resource requests for Pods
and cannot tolerate node failure.

<details>
<summary>Full context</summary>

Total number of CPU requests for pods exceeds cluster capacity.
In case of node failure some pods will not fit in the remaining nodes.

</details>

## Impact

The cluster cannot tolerate node failure. In the event of a node failure, some Pods will be in `Pending` state.

## Diagnosis

- Check if CPU resource requests are adjusted to the app usage
- Check if some nodes are available and not cordoned
- Check if cluster-autoscaler has issues with adding new nodes

## Mitigation

- Add more nodes to the cluster - usually it is better to have more smaller
  nodes, than few bigger.

- Add different node pools with different instance types to avoid problem
  when using only one instance type in the cloud.

- Use pod priorities to avoid important services from losing performance,
  see [pod priority and preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/)

- Fine tune settings for special pods used with [cluster-autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-does-cluster-autoscaler-work-with-pod-priority-and-preemption)

- Prepare performance tests for the expected workload, plan cluster capacity
  accordingly.
