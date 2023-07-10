---
title: Kubelet Server Certificate Renewal Errors
weight: 20
---

# KubeletServerCertificateRenewalErrors

## Meaning

Kubelet on node  has failed to renew its server certificate
(XX errors in the last 5 minutes)

## Impact

**Critical** - Cluster will be in inoperable state.

## Diagnosis

Check when certificate was issued and when it expires.

## Mitigation

Update certificates in the cluster control nodes and the worker nodes.
Refer to the documentation of the tool used to create cluster.

Another option is to delete node if it affects only one,

In extreme situations recreate cluster.
