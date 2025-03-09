---
title: Kube Node Pressure
weight: 20
---

# KubeNodePressure

## Meaning

A node in the Kubernetes cluster has an active pressure condition (`MemoryPressure`, `DiskPressure`, or `PIDPressure`) for more than 10 minutes, indicating resource usage has exceeded eviction thresholds. This alert triggers only if the node is not marked as unschedulable.

<details>
<summary>Full context</summary>

Kubernetes monitors node resources and sets specific conditions when thresholds are exceeded. These conditions indicate that the node is under pressure due to resource constraints, which may lead to pod evictions or scheduling issues. The conditions are:

- **MemoryPressure**: Memory usage is critically high, potentially leading to pod evictions.
- **DiskPressure**: Disk usage or inodes are critically high, potentially affecting pod scheduling or operations.
- **PIDPressure**: The number of running processes (PIDs) is critically high, potentially impacting system stability.

See [Node Conditions](https://kubernetes.io/docs/concepts/architecture/nodes/#condition) and [Eviction Policy](https://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/#eviction).

</details>

## Impact

Potential pod evictions, degraded performance, or unavailability of services running on the affected node. New pods may not be scheduled to the node if the pressure condition persists.

## Diagnosis

- Identify the affected node and cluster using the alert labels: `{{ $labels.node }}` and `{{ $labels.cluster }}`.
- Check the specific condition causing the pressure using the alert label: `{{ $labels.condition }}`.
- Verify the node's resource usage via `kubectl describe node $NODE` to review conditions and resource allocations.
- Check the node's resource metrics (memory, disk, PIDs) via `kubectl top node $NODE` or through your monitoring system (e.g., Prometheus/Grafana).
- Review pod resource requests and limits on the affected node via `kubectl get pod -o wide --all-namespaces | grep $NODE`.
- Check for pods with high resource usage or misconfigured resource limits that may be contributing to the pressure.
- Inspect node logs for additional context via `kubectl logs` on kubelet-related pods or by accessing the node's system logs (e.g., `/var/log/kubelet.log` or equivalent).
- Verify the eviction thresholds configured on the kubelet (e.g., `--eviction-hard`, `--eviction-soft`) by checking the kubelet configuration or startup flags.

Other things to check:

- Pods with unbounded resource usage (e.g., no memory or CPU limits).
- Large numbers of pods or containers causing PID exhaustion.
- Disk usage spikes due to log files, temporary files, or misconfigured storage.
- External workloads or processes consuming resources on the node (e.g., non-Kubernetes processes).

## Mitigation

- Scale down resource-intensive pods or adjust their resource requests/limits to reduce pressure on the node.
- Increase the cluster's capacity by adding more nodes if resource pressure is widespread.
- Drain and cordon the affected node (`kubectl drain $NODE --ignore-daemonsets`) to prevent new pods from being scheduled while troubleshooting.
- Clean up unused or unnecessary files on the node to free up disk space (e.g., old logs, temporary files).
- Adjust kubelet eviction thresholds if they are too aggressive for your workload (e.g., modify `--eviction-hard` or `--eviction-soft` settings).
- Investigate and optimize applications running on the node to reduce resource consumption.
- If the node is running non-Kubernetes workloads, consider isolating Kubernetes workloads to dedicated nodes.

See [Managing Compute Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) and [Node Pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/).
