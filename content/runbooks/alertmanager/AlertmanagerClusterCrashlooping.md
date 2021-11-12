---
title: Alertmanager Cluster Crashlooping
weight: 20
---

# AlertmanagerClusterCrashlooping

## Meaning

Half or more of the Alertmanager instances within the same cluster are crashlooping.

## Impact

Alerts could be notified multiple time unless pods are crashing to fast and no alerts can be sent.

## Diagnosis

```bash
kubectl get pod -l app=alertmanager

NAMESPACE   NAME                    READY   STATUS              RESTARTS    AGE
default     alertmanager-main-0     1/2     CrashLoopBackOff    37107 2d
default     alertmanager-main-1     2/2     Running             0 43d
default     alertmanager-main-2     2/2     Running             0 43d 
```

## Mitigation

Make sure pods have enough resources (CPU, MEM) to work correctly.
