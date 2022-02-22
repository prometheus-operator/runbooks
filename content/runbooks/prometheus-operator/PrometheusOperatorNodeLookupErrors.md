---
title: Prometheus Operator Node Lookup Errors
weight: 20
---

# PrometheusOperatorNodeLookupErrors

## Meaning

Errors while reconciling information about kubernetes nodes.

## Impact

Prometheus Operator is not able to configure Prometheus scrape configuration.

## Diagnosis

Check logs of Prometheus Operator pod.
Check service account tokens.

## Mitigation
