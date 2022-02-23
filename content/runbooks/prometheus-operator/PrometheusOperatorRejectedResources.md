---
title: Prometheus Operator Rejected Resources
weight: 20
---

# PrometheusOperatorRejectedResources

## Meaning

Custom Resources managed by Prometheus Operator were rejected and not propagated to operands (prometheus, alertmanager).

## Impact

Custom Resource won't be used by prometheus-operator and thus configuration it carries won't be translated to prometheus or alertmanager configuration. 

## Diagnosis

- Check newly created Custom Resources like Prometheus, Alertmanager, Rules, Probes, ServiceMonitors, and others that have a CRD used by Prometheus Operator.
- Check logs of Prometheus Operator pod.

## Mitigation

Fix newly created Custom Resource to conform to the schema defined in a CRD and reapply it to the cluster.

Consider using a tool like [`kubeconform`](https://github.com/yannh/kubeconform) to validate newly created resources. You can check [kube-prometheus integration of such a tool in the CI pipeline](https://github.com/prometheus-operator/kube-prometheus/blob/main/Makefile#L65-L67).
