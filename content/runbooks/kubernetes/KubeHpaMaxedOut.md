---
title: Kube HPA Maxed Out
weight: 20
---

# KubeHpaMaxedOut

## Meaning

The Horizontal Pod Autoscaler (HPA) has been running at maximum replicas for longer
than 15 minutes.

## Impact

The Horizontal Pod Autoscaler will not be able to add new pods, thus preventing the
application from scaling. 
**Notice** For some services, maximizing HPA utilization is actually desired.

## Diagnosis

Check why HPA was unable to scale:

- max replicas too low
- too low value for requests such as CPU?

## Mitigation

If using basic metrics like CPU/Memory then ensure to set proper values for
`requests`.
For memory-based scaling, ensure there are no memory leaks.
If using custom metrics, fine-tune how the app scales according to it.

Use performance tests to see how the app scales.
