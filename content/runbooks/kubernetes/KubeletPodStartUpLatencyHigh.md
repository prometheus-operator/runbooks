---
title: Kubelet Pod Start Up Latency High
weight: 20
---

# KubeletPodStartUpLatencyHigh

## Meaning

Kubelet Pod startup 99th percentile latency is XX seconds on node.

## Impact

Slow pod starts.

## Diagnosis

Usually exhaused IOPS for node storage.

## Mitigation

[Cordon and drain node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/) and delete it.
If issue persists look into the node logs.
