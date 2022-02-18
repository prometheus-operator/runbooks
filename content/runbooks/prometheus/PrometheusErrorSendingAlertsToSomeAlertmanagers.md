---
title: Prometheus Error Sending Alerts To Some Alertmanagers
weight: 20
---

# PrometheusErrorSendingAlertsToSomeAlertmanagers

## Meaning

Prometheus has encountered more than 1% errors sending alerts to a specific Alertmanager.

## Impact

Some alerts may be lost.

## Diagnosis

Check connectivity issues between Prometheus and AlertManager.
Check NetworkPolicies, network saturation.
Check if AlertManager is not overloaded or has not enough resources.

## Mitigation

Set multiple AlertManager instances, spread them across nodes.
