---
title: Kube Quota Fully Used
weight: 20
---

# KubeQuotaFullyUsed

## Meaning

Cluster reached allowed limits for given namespace.

## Impact

New app installations may not be possible.

## Diagnosis

- Check resource usage for the namespace in given time span

## Mitigation

- Review existing quota for given namespace and adjust it accordingly.
- Review resources used by the quota and fine tune them.
- Continue with standard capacity planning procedures.
- See [Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
