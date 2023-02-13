---
title: Alertmanager Members Inconsistent
weight: 20
---

# AlertmanagerMembersInconsistent

## Meaning

At least one of alertmanager cluster members cannot be found.

## Impact

## Diagnosis

Check if IP addresses discovered by alertmanager cluster are the same ones as in alertmanager Service. Following example show possible inconsistency in Endpoint IP addresses:

```shell
$ kubectl describe svc alertmanager-main

Name:              alertmanager-main
Namespace:         monitoring
...
Endpoints:         10.128.2.3:9095,10.129.2.5:9095,10.131.0.44:9095

$ kubectl get pod -o wide | grep alertmanager-main

alertmanager-main-0                            5/5     Running   0          11d     10.129.2.6
alertmanager-main-1                            5/5     Running   0          2d16h   10.131.0.44     
alertmanager-main-2                            5/5     Running   0          6d      10.128.2.3  
```

## Mitigation

Deleting an incorrect Endpoint should trigger its recreation with a correct IP address.
