---
title: Prometheus Label LimitHit
weight: 20
---

# PrometheusLabelLimitHit

## Meaning

Prometheus has dropped targets because some scrape configs have exceeded the labels limit.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis


## Mitigation

Start thinking about sharding prometheus.
Increase scrape times to perform it less frequently.
