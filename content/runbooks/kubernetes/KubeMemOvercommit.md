---
title: Kube Memory Overcommit
weight: 20
---

# KubeMemOvercommit

## Meaning

Cluster has overcommitted Memory resource requests for Pods
and cannot tolerate node failure.

<details>
<summary>Full context</summary>

Total number of Memory requests for pods exceeds cluster capacity.
In case of node failure some pods will not fit in the remaining nodes.

</details>

## Impact

Various services degradation or unavailability in case of single node failure.

## Diagnosis

- Check if Memory resource requests are adjusted to the app usage
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
