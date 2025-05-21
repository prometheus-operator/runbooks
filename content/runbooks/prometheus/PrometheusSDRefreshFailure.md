# PrometheusSDRefreshFailure

## Meaning

Prometheus fails to refresh its service discovery (SD) targets. This might indicate connectivity issues to SD providers (such as Kubernetes, Consul, DNS), misconfiguration, or internal errors within Prometheus.

## Impact

Missing or stale service discovery information leads new targets not being scraped and old target are not removed from the configuration, resulting in invalid metrics and alerts.

## Diagnosis

The root causes for this issue can be pretty diverse, but here are some hints where to start:
- Check Prometheus logs for specific SD-related error messages.
- Ensure your Prometheus SD configuraion is formally correct.
- Verify network connectivity between Prometheus and SD endpoints.
- Based on the info from the steps before, check whether there are recent changes in Prometheus' configuration, the SD endpoints, network policies, or authentication credentials.

## Mitigation

Fix network issues that prevent Prometheus from reaching SD endpoints.

Check whether DNS resolution is working correctly in the cluster.

Check credentials and permissions are correct.

As a last resort, remove configuration for failing SD endpoints.
