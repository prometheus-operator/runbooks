---
title: NodeMemoryMajorPagesFaults
weight: 20
---

# NodeMemoryMajorPagesFaults

## Meaning

The `NodeMemoryMajorPagesFaults` alert is triggered when a Kubernetes node experiences a significant number of major page faults, indicating issues with memory access. This could be due to excessive swapping of memory pages to the swap area or general memory problems.

As shown here: 
[Kubernetes-Mixin](https://monitoring.mixins.dev/node-exporter/)
> Memory major pages are occurring at very high rate at {{ $labels.instance }}, 500 major page faults per second for the last 15 minutes, is currently at {{ printf "%.2f" $value }}. 
>
> Please check that there is enough memory available at this instance. 

## Impact

- Possible performance degradation for applications running on the affected Kubernetes node.
- Increased latency for memory accesses.
- Risk of application crashes or errors due to memory overload.

## Diagnosis

1. Check the utilization of physical memory (RAM) and swap space on the affected Kubernetes node.
2. Examine the memory profiles of running applications to determine which processes are consuming memory.
3. Monitor memory usage over time to identify trends and peak loads.


## Mitigation

1. Optimize the resource utilization of running applications by stopping unnecessary processes or adjusting their resource requirements.
2. Review Kubernetes resource requests and limits configuration to ensure they match the actual requirements of the applications.
3. Scale the resources of the Kubernetes node as needed by adding additional memory or increasing node capacity.
4. Optimize swap configuration to ensure efficient utilization while minimizing the impact of swapping on performance.
