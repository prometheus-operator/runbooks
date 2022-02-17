---
title: Kube Client Certificate Expiration
weight: 20
---

# KubeClientCertificateExpiration

## Meaning

A client certificate used to authenticate to the apiserver is expiring

## Impact

Client will not be able to interact with the cluster.
Sor in cluster services this may degrade or make service unavailable.

## Diagnosis

Check when certificate was issued and when it expires.

## Mitigation

Update client certificate.

For in-cluster clients recreate pods, check serviceAccounts and service
account tokens.
