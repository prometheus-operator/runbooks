---
title: Prometheus Remote Write Behind
weight: 20
---

# PrometheusRemoteWriteBehind

## Meaning

Prometheus remote write is behind.

## Impact

Metrics and alerts may be missing or inaccurate.
Increased data lag between locations.

## Diagnosis

Check prometheus logs and remote storage logs.
Investigate network issues.
Check configs and credentials.

## Mitigation

Probbaly amout of data sent to remote system is too high
for given network connectivity speed.
You may need to limit which metrics to send to minimize transfers.

See [Prometheus Remote Storage Failures]({{< ref "./PrometheusRemoteStorageFailures.md" >}})
