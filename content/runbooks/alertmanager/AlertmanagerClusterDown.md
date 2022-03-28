---
title: Alertmanager Cluster Down
weight: 20
---

# AlertmanagerClusterDown

## Meaning

Half or more of the Alertmanager instances within the same cluster are down. 

## Impact

You have an unstable cluster, if everything goes wrong you will lose the whole cluster.

## Diagnosis

Verify why pods are not running.
You can get a big picture with `events`.

```shell
$ kubectl get events --field-selector involvedObject.kind=Pod | grep alertmanager
```

## Mitigation

There are no cheap options to mitigate this risk.
Verifying any new changes in preprod before production environment should improve stability.  
