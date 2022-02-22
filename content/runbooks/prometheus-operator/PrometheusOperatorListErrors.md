---
title: Prometheus Operator List Errors
weight: 20
---

# PrometheusOperatorListErrors

## Meaning

Errors while performing list operations in controller.

## Impact

Prometheus Operator has troubles in managing its operands and Custom Resources.

## Diagnosis

- Check logs of Prometheus Operator pod.
- Check service account tokens.
- Check Prometheus Operator RBAC configuration.

## Mitigation
