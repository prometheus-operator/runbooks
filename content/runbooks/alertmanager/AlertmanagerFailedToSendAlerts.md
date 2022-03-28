---
title: Alertmanager Failed To Send Alerts
weight: 20
---

# AlertmanagerFailedToSendAlerts

## Meaning

At least one instance is unable to routed alert to the corresponding integration.

## Impact

No impact since another instance should be able to send the notification,
unless `AlertmanagerClusterFailedToSendAlerts` is also triggerd for the same integration.

## Diagnosis

Verify the amount of failed notification per alert-manager-[instance] for
a specific integration.

You can look metrics exposed in prometheus console using promQL.
For exemple the following query will display the number of failed
notifications per instance for pager duty integration.
We have 3 instances involved in the example bellow.

```promql
rate(alertmanager_notifications_total{integration="pagerduty"}[5m])
```

![image](https://user-images.githubusercontent.com/3153333/143552468-ff573f1a-19a6-44ea-9c85-631687d01bf9.png)


## Mitigation

Depending on the integration, you can have a look to alert-manager logs and act (network, authorization token, firewall...)

Depending on the integration, you can have a look to alert-manager logs
and act (network, authorization token, firewall...)

```shell
kubectl -n monitoring logs -l 'alertmanager=main' -c alertmanager
```
