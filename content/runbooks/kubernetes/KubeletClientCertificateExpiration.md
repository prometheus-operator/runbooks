---
title: Kubelet Client Certificate Expiration
weight: 20
---

# KubeletClientCertificateExpiration

## Meaning

Client certificate for Kubelet on node expires soon or already expired.

## Impact

Node will not be able to be used within the cluster.

## Diagnosis

Check when certificate was issued and when it expires.

## Mitigation

Update certificates in the cluster control nodes and the worker nodes.
Refer to the documentation of the tool used to create cluster.

Another option is to delete node if it affects only one,

In extreme situations recreate cluster.
