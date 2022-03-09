---
title: Prometheus Not Connected To Alertmanagers
weight: 20
---

# PrometheusNotConnectedToAlertmanagers

## Meaning

Prometheus is not connected to any Alertmanagers.

## Impact

Sending alerts is not possible.

## Diagnosis

Check connectivity issues between Prometheus and AlertManager.
Check NetworkPolicies, network saturation.
Check if AlertManager is not overloaded or has not enough resources.

## Mitigation

Set multiple AlertManager instances, spread them across nodes.
