---
title: Prometheus Operator Watch Errors
weight: 20
---

# PrometheusOperatorWatchErrors

## Meaning

Errors while performing watch operations in controller.

## Impact

Prometheus Operator will not be able to manage Prometheuses/Alertmanagers.

## Diagnosis

Check logs of Prometheus Operator pod.
Check service account tokens.

## Mitigation
