# SubscriptionEventPostbackProcessorTooMany5xxErrors

## Meaning

There is a high volume of non-trivial 5xx errors on `go-monorepo/SubscriptionEventPostbackProcessor` that are not expected


<details>
<summary>Full context</summary>

HTTP 5xx errors usually happen when requests can’t be handled correctly, or take longer than a few seconds, due to some bug in the code or unavailability of one or more services that are required to complete some requests (i.e. databases, APIs, etc).

</details>

## Impact

Since this repository is responsible for processing subscription events, a high volume of 5xx errors can mean that some subscription events are not being processed correctly. This can lead to not sending or delaying sending emails to users, which can impact the user experience.

## Diagnosis

Check the logs of the `go-monorepo/SubscriptionEventPostbackProcessor` to see if there are any errors that can explain the high volume of 5xx errors.

## Mitigation

If the 5xx errors started after a new deployment, try to rollback the deployment to the last stable version. Investigate the root cause of the issue and fix it before deploying again. If the 5xx errors are due to unavailability of a service, try to make the service more resilient by adding retries, timeouts, or circuit breakers.
