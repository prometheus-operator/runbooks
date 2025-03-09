# If soft thresholds are crossed, pods will be evicted respecting TerminationGracePeriod. If Hard thresholds are crossed grace period will be ignored.


---
title: Kube Node Eviction
weight: 20
---

# KubeNodeEviction

## Meaning

A node in the Kubernetes cluster is actively evicting pods due to resource usage exceeding eviction thresholds, typically caused by pods exceeding RAM or ephemeral storage limits. The alert is triggered immediately when evictions are detected, and closes 15 minutes after no new evictions have occured.

<details>
<summary>Full context</summary>

Kubernetes uses an eviction mechanism to reclaim resources on nodes when resource usage exceeds configured thresholds. The kubelet monitors resource usage and evicts pods based on priority and resource consumption. Common eviction signals include:

- **memory.available**: Memory usage is critically high.
- **nodefs.available**: Disk usage on the root filesystem is critically high.
- **nodefs.inodesFree**: Inodes on the root filesystem are exhausted.
- **imagefs.available**: Disk usage for container images is critically high.

Each of these signals has two thresholds; **soft** and **hard**. When the soft threshold is crossed, kubelet terminates pods respecting their `TerminationGracePeriod`; When hard is crossed it ignores this.  Below are the default values for each of the above signals:

| Eviction Signal       | Soft Threshold (Default) | Hard Threshold (Default) |
|-----------------------|--------------------------|--------------------------|
| memory.available      | < 10% of total memory    | < 100MiB (absolute)      |
| nodefs.available      | < 10% of root filesystem | < 5% of root filesystem  |
| nodefs.inodesFree     | < 10% of inodes          | < 5% of inodes           |
| imagefs.available     | < 10% of image filesystem (if separate) | < 5% of image filesystem (if separate) |

See [Node Pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/) and [Pod Priority and Preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/).

</details>

## Impact

Service degradation or unavailability due to evicted pods. Evicted pods may fail to reschedule if the cluster is under resource pressure, leading to outages.

## Diagnosis

- Identify the affected node and cluster using the alert labels: `{{ $labels.node }}` and `{{ $labels.cluster }}`.
- Check the specific eviction signal causing the issue using the alert label: `{{ $labels.eviction_signal }}`.
- Review the node's resource usage via `kubectl describe node $NODE` to confirm the pressure condition and evicted pods.
- Check the node's resource metrics (memory, disk, inodes) via `kubectl top node $NODE` or through your monitoring system (e.g., Prometheus/Grafana).
- Identify evicted pods via `kubectl get pod -o wide --all-namespaces | grep $NODE` and look for pods in `Evicted` or `Failed` state.
- Check pod events for eviction details via `kubectl -n $NAMESPACE describe pod $POD`.
- Review pod resource requests and limits on the affected node to identify potential culprits via `kubectl get pod -o wide --all-namespaces | grep $NODE`.
- Inspect node logs for eviction-related messages via `kubectl logs` on kubelet-related pods or by accessing the node's system logs (e.g., `/var/log/kubelet.log` or equivalent).
- Verify the eviction thresholds configured on the kubelet (e.g., `--eviction-hard`, `--eviction-soft`) by checking the kubelet configuration or startup flags.

Other things to check:

- Pods with unbounded resource usage (e.g., no memory or CPU limits) causing evictions.
- Disk usage spikes due to log files, temporary files, or misconfigured storage.
- Low-priority pods being evicted due to high-priority pods consuming resources.
- External workloads or processes consuming resources on the node (e.g., non-Kubernetes processes).

## Mitigation

- Identify and scale down resource-intensive pods or adjust their resource requests/limits to prevent further evictions.
- Increase the cluster's capacity by adding more nodes if resource pressure is widespread.
- Drain and cordon the affected node (`kubectl drain $NODE --ignore-daemonsets`) to prevent new pods from being scheduled while troubleshooting.
- Clean up unused or unnecessary files on the node to free up disk space (e.g., old logs, temporary files, unused images).
- Adjust kubelet eviction thresholds if they are too aggressive for your workload (e.g., modify `--eviction-hard` or `--eviction-soft` settings).
- Investigate and optimize applications running on the node to reduce resource consumption.
- Use pod priority classes to ensure critical pods are not evicted in favor of less important ones.
- If the node is running non-Kubernetes workloads, consider isolating Kubernetes workloads to dedicated nodes.

See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) and [Node Pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/).
