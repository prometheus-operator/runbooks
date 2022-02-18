---
title: Prometheus Operator Sync Failed
weight: 20
---

# PrometheusOperatorSyncFailed

## Meaning

Last controller reconciliation failed

## Impact

Prometheus Operator will not be able to manage Prometheuses/Alertmanagers.

## Diagnosis

Check logs of Prometheus Operator pod.
Check service account tokens.

## Mitigation
