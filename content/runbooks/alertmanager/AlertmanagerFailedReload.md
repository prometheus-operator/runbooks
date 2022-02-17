---
title: Alertmanager Failed Reload
weight: 20
---

# AlertmanagerFailedReload

## Meaning

The alert `AlertmanagerFailedReload` is triggered when the Alertmanager instance
for the cluster monitoring stack has consistently failed to reload its
configuration for a certain period.

## Impact

The impact depends on the type of the error you will find in the logs.
Most of the time, previous configuration is still working, thanks to multiple
instances, so avoid deleting existing pods.

## Diagnosis

Verify if there is an error in `config-reloader` container logs.
Here an example with network issues.

```bash
$ kubectl logs sts/alertmanager-main -c config-reloader

level=error ts=2021-09-24T11:24:52.69629226Z caller=runutil.go:101 msg="function failed. Retrying in next tick" err="trigger reload: reload request failed: Post \"http://localhost:9093/alertmanager/-/reload\": dial tcp [::1]:9093: connect: connection refused"
```

You can also verify directly `alertmanager.yaml` file (default: `/etc/alertmanager/config/alertmanager.yaml`).

## Mitigation

Running [amtool check-config alertmanager.yaml](https://github.com/prometheus/alertmanager#amtool)
on your configuration file will help you detect problem related to syntax.
You could also rollback `alertmanager.yaml` to the previous version in order
to get back to a stable version. 
