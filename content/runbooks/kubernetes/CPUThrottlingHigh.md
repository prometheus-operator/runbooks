---
title: CPU Throttling High
weight: 20
---

# CPUThrottlingHigh

## Meaning

Given container in the pod is throttled to avoid excessive CPU usage.

## Impact

Usually application latency spikes.

## Diagnosis

- Check if CPU resource requests are adjusted accordingly to the app usage
- Check kernel version in the node

## Mitigation

Give specific container in the pod more CPU requests and limits.

In specific cases kubernetes node has too old kernel which is known to have
issues with assigning CPU resources to the process [see here](https://github.com/kubernetes/kubernetes/issues/67577)

In certain scenarios ensure to use CPU Pinning and isolation - in short give to the container full CPU cores.
Also ensure to update app so that it is aware it runs in cgropus, or explicitly set number of CPU it can use, or limit number of threads.

Longer and more detailed info - [PDF from Intel](https://builders.intel.com/docs/networkbuilders/cpu-pin-and-isolation-in-kubernetes-app-note.pdf)
