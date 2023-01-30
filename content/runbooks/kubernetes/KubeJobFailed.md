# KubeJobFailed

## Meaning

This alert fires if a [Kubernetes Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/) has failed.  

<details>
<summary>Full context</summary>

  These Jobs may be spawned by a [Kubernetes CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/), or created as one-off tasks. 

</details>

## Impact

The Job exited with a non successful status, the Impact may vary depending on the Pod spun up and what it is supposed to do. 

## Diagnosis

Pods the Job created can be checked for logs.  This may be time-sensitive as Jobs can be configured to auto-clean failed tasks after a time, or after so many repeated failures. 

https://kubernetes.io/docs/concepts/workloads/controllers/job/#handling-pod-and-container-failures

## Mitigation

Errors shown by the Pod should be resolved, or some reconfiguration of the task the Pod runs may need to be set up so that it exits with a successful return code. 

Failed Jobs should be removed, after reviewing the logs.  This will clean up the failed pods.  https://kubernetes.io/docs/concepts/workloads/controllers/job/#job-termination-and-cleanup

Finished/Terminated pods can also be set to be cleaned up automatically, see https://kubernetes.io/docs/concepts/workloads/controllers/job/#clean-up-finished-jobs-automatically

You may want to re-run the Job.  If created from a Cronjob, you can do this like so:
  
    kubectl create job --from=cronjob/<name of cronjob> <name of job>

