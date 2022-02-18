---
title: Kube State Metrics Shards Missing
weight: 20
---

# KubeStateMetricsShardsMissing

## Meaning

kube-state-metrics shards are missing.

## Impact

Unable to get metrics for certain resources.
Some metrics can be unavailable.

## Diagnosis

Check kube-state-metric container logs for each shard.
Check if certain pods were forcefully evicted.
Check service account token.
Check networking rules and network policies.

## Mitigation
