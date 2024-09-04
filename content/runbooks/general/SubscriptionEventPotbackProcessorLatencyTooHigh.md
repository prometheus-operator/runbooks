# SubscriptionEventPotbackProcessorLatencyTooHigh

## Meaning

The alert means that the latency of the `go-monorepo/SubscriptionEventPostbackProcessor` is higher than expected.

<details>
<summary>Full context</summary>

Latency is the time taken to process a request. High latency can be caused by a variety of reasons, such as a high volume of requests, a slow database, or a slow network connection. High latency can impact the user experience, as users may have to wait longer to receive emails from the service.

</details>

## Impact

Since this repository is responsible for processing subscription events, high latency can mean that some subscription events are not being processed correctly. This can lead to not sending or delaying sending emails to users, which can impact the user experience.

## Diagnosis

To diagnose the issue, check the logs of the `go-monorepo/SubscriptionEventPostbackProcessor` to see if there are any errors that can explain the high latency. Also, check the deployment history to see if there are any recent deployments that could have caused the high latency. Timeouts, slow queries, or high CPU usage can be some of the reasons for high latency.

## Mitigation

If the high latency started after a new deployment, try to rollback the deployment to the last stable version. Investigate the root cause of the issue and fix it before deploying again. If the high latency is due to a high volume of requests, consider scaling the service horizontally or vertically to handle the load.
