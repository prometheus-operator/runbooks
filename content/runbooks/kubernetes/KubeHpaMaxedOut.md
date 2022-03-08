---
title: Kube HPA Maxed Out
weight: 20
---

# KubeHpaMaxedOut

## Meaning

Horizontal Pod Autoscaler has been running at max replicas for longer
than 15 minutes.

## Impact

Horizontal Pod Autoscaler won't be able to add new pods and thus scale application.
**Notice** for some services maximizing HPA is in fact desired.

## Diagnosis

Check why HPA was unable to scale:

- max replicas too low
- too low value for requests such as CPU?

## Mitigation

If using basic metrics like CPU/Memory then ensure to set proper values for
`requests`.
For memory based scaling ensure there are no memory leaks.
If using custom metrics then tine tune how app scales accordingly to it.

Use performance tests to see how the app scales.
