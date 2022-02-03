# TargetDown

## Meaning

The alert means that one or more prometheus scrape targets are down. It fires when at least 10% of scrape targets in a Service are unreachable.

<details>
<summary>Full context</summary>

Prometheus works by sending an HTTP GET request to all of its "targets" every few seconds. So TargetDown really means that Prometheus just can't access your service, which may or may not mean it's actually down. If your service appears to be running fine, a common cause could be a misconfigured ServiceMonitor (maybe the port or path is incorrect), a misconfigured NetworkPolicy, or Service with incorrect labelSelectors that isn't selecting any Pods.

</details>

## Impact

Metrics from a particular target cannot be scraped as such there is no data for this target in Prometheus and alerting can be hindered.

## Diagnosis

`/targets` page in Prometheus UI can be used to check the scrape error for the particular target.

`up == 0` query can be used to check the trend over time.

## Mitigation

Mitigation depends on the error reported by prometheus and there is no generic one.
