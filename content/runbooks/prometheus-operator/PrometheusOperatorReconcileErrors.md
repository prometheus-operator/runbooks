---
title: Prometheus Operator Reconcile Errors
weight: 20
---

# PrometheusOperatorReconcileErrors

## Meaning

Errors while reconciling controller.

## Impact

Prometheus Operator will not be able to manage Prometheuses/Alertmanagers.

## Diagnosis

Check logs of Prometheus Operator pod.
Check service account tokens.

## Mitigation
