---
title: Prometheus Notification Queue Running Full
weight: 20
---

# PrometheusNotificationQueueRunningFull

## Meaning

Prometheus alert notification queue predicted to run full in less than 30m.

## Impact

Fail to send alerts.

## Diagnosis

Check prometheus container logs for an explanation of which part of the
configuration is problematic.

## Mitigation

Remove conflicting configuration option.

Check if there is an option to decrease number of alerts firing,
for example by sharding prometheus.
