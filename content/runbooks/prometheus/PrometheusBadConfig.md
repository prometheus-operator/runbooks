---
title: Prometheus Bad Config
weight: 20
---

# PrometheusBadConfig

## Meaning

Alert fires when Prometheus cannot successfully reload the configuration file
due to the file having incorrect content.

## Impact

Configuration cannot be reloaded and prometheus operates with last known good
configuration.
Configuration changes in any of Prometheus, Probe, PodMonitor,
or ServiceMonitor objects may not be picked up by prometheus server.

## Diagnosis

Check prometheus container logs for an explanation of which part of the
configuration is problematic.

Usually this can occur when ServiceMonitors or
PodMonitors share the same job label.

## Mitigation

Remove conflicting configuration option.
