---
title: PrometheusRemoteWriteDesiredShards
weight: 20
---

# PrometheusRemoteWriteDesiredShards

## Meaning

Prometheus remote write desired shards calculation wants to run
more than configured max shards.
      

## Impact

Metrics and alerts may be missing or inaccurate.


## Diagnosis

Check metrics cardinality.

Check prometheus logs and remote storage logs.
Investigate network issues.
Check configs and credentials.

## Mitigation

Probbaly amout of data sent to remote system is too high
for given network connectivity speed.
You may need to limit which metrics to send to minimize transfers.

See [Prometheus Remote Storage Failures]({{< ref "./PrometheusRemoteStorageFailures.md" >}})
