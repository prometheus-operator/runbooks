---
title: Node System Saturation
weight: 20
---

# NodeSystemSaturation

## Meaning

This alert fires when the system load per core on a node has been above 2 for the
last 15 minutes. The alert indicates that the instance is experiencing resource
saturation, which can cause the node to become unresponsive. This is a critical
alert as it directly impacts the node's ability to serve workloads effectively.

<details>
<summary>Full context</summary>

System load represents the average system demand for CPU resources over time. When
the load per core exceeds 2, it indicates that the system is under significant
stress and may not be able to handle additional workloads efficiently. This can
lead to increased response times, failed requests, and in severe cases, the node
becoming unresponsive or requiring a reboot.

</details>

## Impact

High system load per core indicates that the node is struggling to process its
current workload. This can cause:
- Increased response times for applications
- Failed or delayed pod scheduling
- Potential node instability or unresponsiveness
- Cascading effects on other nodes if workloads are redistributed

## Diagnosis

Monitor the system load trends using the following PromQL query to understand the
current and historical load patterns:

1. Find Spikes in CPU Load
```promql
node_load1{instance="<INSTANCE>"}
```
2. Select the timeframe of the spike to drill down
3. Get top 20 Containers by CPU usage
```promql
topk(20, sum by (container, pod, namespace) (
  rate(container_cpu_usage_seconds_total{node="<INSTANCE>", container!=""}[5m])
))
````

Check the alert's `instance` label to identify the affected node. Additional
metrics to investigate include:

- CPU usage per core
- Memory usage
- I/O wait times
- Network utilization

## Mitigation

To resolve high system load issues:

1. **Immediate Actions:**
   - Check for runaway processes consuming excessive CPU
   - Identify and terminate unnecessary workloads
   - Consider evicting non-critical pods from the node

2. **Investigation Steps:**
   
   First, create a debug pod to access the node. See the [kubectl debug documentation](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/#examples) for detailed instructions on creating debug pods.
   
   ```shell
   # Access the node for debugging e.g.
   $ NODE_NAME=<instance label from alert>
   $ kubectl debug node/$NODE_NAME -it --image=alpine
   $ chroot /host
   
   # Check system load and top processes
   $ top
   $ apk add procps-ng
   $ ps aux --sort=-%cpu | head -n 21
   
   # Check for high I/O wait
   $ apk add sysstat
   $ iostat -x 1 5
   
   # Check memory usage
   $ free -h

   # Exit debug mode when finished:
    $ exit
   ```

3. **Long-term Solutions:**
   - Scale the cluster by adding more nodes
   - Optimize application resource requests and limits
   - Implement proper resource quotas
   - Consider node taints/tolerations for workload distribution
