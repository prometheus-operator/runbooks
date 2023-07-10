---
title: Kube Aggregated API Errors
weight: 20
---

# KubeAggregatedAPIErrors

## Meaning

Kubernetes aggregated API has reported errors.
It has appeared unavailable over 4 times averaged over the past 10m.

## Impact

From minor such as inability to see cluster metrics to more severe such as
unable to use custom metrics to scale or even unable to use cluster.

## Diagnosis

- Check networking on the node.
- Check firewall on the node.
- Investigate additional API logs.
- Investigate NetworkPolicies if kubeApi - additional API was not filtered out.
- Investigate NetworkPolicies if prometheus/additional API was not filtered out.

## Mitigation

TODO

See [APIServer aggregation](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/)
