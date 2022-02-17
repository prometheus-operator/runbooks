---
title: Kube Client Errors
weight: 20
---

# KubeClientErrors

## Meaning

Kubernetes API server client is experiencing some errors.

## Impact

Specific kubernetes client may malfunction. Service degradation.

## Diagnosis

Check logs from client side (sometimes app logs).

## Mitigation

Usual issues:

- networking errors
- too low resources to perform given API calls (usually too low CPU/memory requests)
- wrong api client (old libraries)
- investigate if the app does not request more data than it really requires
  from kubernetes API, for example it has too wide permissions and scans for
  resources in all namespaces.
