---
title: Kube HPA  Replicas Mismatch
weight: 20
---

# KubeHpaReplicasMismatch

## Meaning

Horizontal Pod Autoscaler has not matched the desired number of replicas for
longer than 15 minutes.

HPA was unable to schedule desired number of pods.

## Impact

Possible service degradation.

## Diagnosis

Check why HPA was unable to scale:

- not enough nodes in the cluster
- hitting resource quotas in the cluster
- pods evicted due to pod priority

## Mitigation

In case of cluster-autoscaler you may need to set up preemtive pod pools to
ensure nodes are created on time.
