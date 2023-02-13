---
title: Prometheus TSDB Compactions Failing
weight: 20
---

# PrometheusTSDBCompactionsFailing

## Meaning

Prometheus has issues compacting blocks.

## Impact

Metrics and alerts may be missing or inaccurate.

## Diagnosis

Check storage used by the pod.
This can happen if there is a lot of going on in the cluster and
prometheus did not manage to compact data.

## Mitigation

At first just wait, it may fix itself after some time.

Increase Prometheus pod memory so that it caches more from disk.
Try expanding volumes if they are too small or too slow.
Change PVC storageClass to a more performant one.
