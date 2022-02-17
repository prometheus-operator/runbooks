---
title: KubeProxy Down
weight: 20
---

# KubeProxyDown

## Meaning

KubeProxy has disappeared from Prometheus target discovery.

## Impact

kube-proxy is a network proxy that runs on each node in your cluster,
implementing part of the Kubernetes Service concept.

kube-proxy maintains network rules on nodes.
These network rules allow network communication to your Pods
from network sessions inside or outside of your cluster.

kube-proxy uses the operating system packet filtering layer if
there is one and it's available. Otherwise, kube-proxy forwards the traffic itself.

## Diagnosis

Check networking on the node.
Check firewall on the node.
Investigate kube proxy logs.
Investigate NetworkPolicies if prometheus/kubeproxy was not filtered out.

## Mitigation

TODO
