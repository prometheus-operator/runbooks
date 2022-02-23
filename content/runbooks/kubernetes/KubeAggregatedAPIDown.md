---
title: Kube Aggregated API Down
weight: 20
---

# KubeAggregatedAPIDown

## Meaning

Kubernetes aggregated API has reported errors.
It has appeared unavailable X times averaged over the past 10m.

## Impact

From minor such as inability to see cluster metrics to more severe such as
unable to use custom metrics to scale or even unable to use cluster.

## Diagnosis

- Check networking on the node.
- Check firewall on the node.
- Investigate additional API logs.
- Investigate NetworkPolicies if kubeApi - additional API was not filtered out.
- Investigate NetworkPolicies if prometheus/additional api was not filtered out.

## Mitigation

TODO

See [APIServer aggregation](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/)
