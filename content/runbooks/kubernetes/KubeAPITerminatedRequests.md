---
title: Kube API Terminated Requests
weight: 20
---

# KubeAPITerminatedRequests

## Meaning

The apiserver has terminated XX% of its incoming requests.

## Impact

Client will not be able to interact with the cluster.
Some in-cluster services this may degrade or make service unavailable.

## Diagnosis

Use the `apiserver_flowcontrol_rejected_requests_total` metric to determine
which flow schema is throttling the traffic to the API Server.
The flow schema also provides information on the affected resources and subjects.

## Mitigation

TODO
