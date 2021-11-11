---
title: Alertmanager Failed To Send Alerts
weight: 20
---

# AlertmanagerFailedToSendAlerts

## Meaning

At least one instance is unable to routed alert to the corresponding integration.

## Impact

No impact since another instance will be able to send the notification.

## Diagnosis

Verify that alerts send by each instance have equivalent alert distribution per integration.

## Mitigation

Depending on the integration, correct the integration with the faulty instance (network, authorization token, firewall...)
