---
title: Kube State Metrics Sharding Mismatch
weight: 20
---

# KubeStateMetricsShardingMismatch

## Meaning

kube-state-metrics sharding is misconfigured.

## Impact

Unable to get metrics for certain resources.
Some metrics can be unavailable.

## Diagnosis

Check kube-state-metric container logs for each shard.
Check service account token.
Check networking rules and network policies.

## Mitigation
