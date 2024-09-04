# SubscriptionEventPostbackProcessorTooManyRestarts

## Meaning

There is a high volume of restarts on `go-monorepo/SubscriptionEventPostbackProcessor` that are not expected


<details>
<summary>Full context</summary>

Restarts can happen for a variety of reasons, such as a crash, a manual restart, or a deployment. A high volume of restarts can indicate that the service is not stable. This can be due to a bug in the code, a misconfiguration, or a resource constraint.

</details>

## Impact

Since this repository is responsible for processing subscription events, a high volume of restarts can mean that some subscription events are not being processed correctly. This can lead to not sending or delaying sending emails to users, which can impact the user experience.

## Diagnosis

To diagnose the issue, check the logs of the `go-monorepo/SubscriptionEventPostbackProcessor` to see if there are any errors that can explain the high volume of restarts, also check the deployment history to see if there are any recent deployments that could have caused the restarts.

## Mitigation

If the restarts started after a new deployment, try to rollback the deployment to the last stable version. Then investigate the root cause of the issue and fix it before deploying again.
