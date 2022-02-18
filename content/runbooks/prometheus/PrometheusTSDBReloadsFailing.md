---
title: Prometheus TSDB Reloads Failing
weight: 20
---

# PrometheusTSDBReloadsFailing

## Meaning

Prometheus has issues reloading blocks from disk.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis

Check storage used by the pod.

## Mitigation

Increase Prometheus pod memory so that it caches more from disk.
Try expanding volumes if they are too small or too slow.
Change PVC storageClass to a more performant one.
