---
title: Kube CPU Quota Overcommit
weight: 20
---

# KubeCPUQuotaOvercommit

## Meaning

Cluster has overcommitted CPU resource requests for Namespaces.

## Impact

In the event of a node failure, some Pods will be in `Pending` state due to a lack of available CPU resources.

## Diagnosis

- Check if CPU resource requests are adjusted to the app usage
- Check if some nodes are available and not cordoned
- Check if cluster-autoscaler has issues with adding new nodes
- Check if the given namespace usage grows in time more than expected

## Mitigation

- Review existing quota for given namespace and adjust it accordingly.

- Add more nodes to the cluster - usually it is better to have more smaller
  nodes, than few bigger.

- Add different node pools with different instance types to avoid problem
  when using only one instance type in the cloud.

- Use pod priorities to avoid important services from losing performance,
  see [pod priority and preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/)

- Fine tune settings for special pods used with [cluster-autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-does-cluster-autoscaler-work-with-pod-priority-and-preemption)

- Prepare performance tests for the expected workload, plan cluster capacity
  accordingly.
