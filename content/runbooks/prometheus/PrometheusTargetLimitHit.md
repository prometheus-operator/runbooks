---
title: Prometheus Target Limit Hit
weight: 20
---

# PrometheusTargetLimitHit

## Meaning

Prometheus has dropped targets because some scrape configs have exceeded the targets limit.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis


## Mitigation

Start thinking about sharding prometheus.
Increase scrape times to perform it less frequently.
