---
title: Alertmanager ConfigInconsistent
weight: 20
---

# AlertmanagerConfigInconsistent

## Meaning

The configuration between instances inside a cluster is inconsistent.

## Impact

Configuration inconsistency can be multiple and impact is hard to predict. 
Nevertheless, most of the case the alert might be lost or routed to the incorrect integration. 

## Diagnosis

Run a `diff` tool between all `alertmanager.yml` that are deployed to find what is wrong.
You could run a job within your CI to avoid this issue in the future.

## Mitigation

Delete the incorrect secret and deploy the correct one.
