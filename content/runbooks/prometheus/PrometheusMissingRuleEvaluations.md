---
title: Prometheus Missing Rule Evaluations
weight: 20
---

# PrometheusMissingRuleEvaluations

## Meaning

Prometheus is missing rule evaluations due to slow rule group evaluation.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis

Check which rules fail, try to calcuate them differently.

## Mitigation

Sometimes giving more CPU is the only way to fix it.
