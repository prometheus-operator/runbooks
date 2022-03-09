---
title: Prometheus Error Sending Alerts To Any Alertmanager
weight: 20
---

# PrometheusErrorSendingAlertsToAnyAlertmanager

## Meaning

Prometheus has encountered errors sending alerts to a any Alertmanager.

## Impact

All alerts may be lost.

## Diagnosis

Check connectivity issues between Prometheus and AlertManager cluster.
Check NetworkPolicies, network saturation.
Check if AlertManager is not overloaded or has not enough resources.

## Mitigation

Set multiple AlertManager instances, spread them across nodes.
