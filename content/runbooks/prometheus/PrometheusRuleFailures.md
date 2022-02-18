---
title: Prometheus Rule Failures
weight: 20
---

# PrometheusRuleFailures

## Meaning

Prometheus is failing rule evaluations.
Prometheus rules are incorrect or failed to calculate.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis

Your best starting point is the rules page of the Prometheus UI (:9090/rules).
It will show the error.

You can also evaluate the rule expression yourself, using the UI, or maybe
using PromLens to help debug expression issues.

## Mitigation

Fix rules.
