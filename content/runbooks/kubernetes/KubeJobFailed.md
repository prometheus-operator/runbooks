---
title: Kube Job Failed
weight: 20
---

# KubeJobFailed

## Meaning

This alert fires if a [Kubernetes Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/) has failed.  

<details>
<summary>Full context</summary>

  These Jobs may be spawned by a [Kubernetes CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/), or created as one-off tasks. 

</details>

## Impact

Failure processing a scheduled task.

## Diagnosis

- Check job via `kubectl -n $NAMESPACE describe jobs $JOB`.
- Check pod events via `kubectl -n $NAMESPACE describe pod $POD_FROM_JOB`.
- Check pod logs via `kubectl -n $NAMESPACE log pod $POD_FROM_JOB`.
- See also [handling-pod-and-container-failures](https://kubernetes.io/docs/concepts/workloads/controllers/job/#handling-pod-and-container-failures)

## Mitigation

Errors shown by the Pod should be resolved, or some reconfiguration of the task the Pod runs may need to be set up so that it exits with a successful return code. 

- See [Debugging Pods](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods)
- See [Job patterns](https://kubernetes.io/docs/tasks/job/)
- redesign job so that it is idempotent (can be re-run many times which will always produce the same output even if input differes)
- Failed Jobs should be removed, after reviewing the logs.  This will clean up the failed pods.  https://kubernetes.io/docs/concepts/workloads/controllers/job/#job-termination-and-cleanup
- Finished/Terminated pods can also be set to be cleaned up automatically, see https://kubernetes.io/docs/concepts/workloads/controllers/job/#clean-up-finished-jobs-automatically
- You may want to re-run the Job.  If created from a Cronjob, you can do this like so:
  
      kubectl create job --from=cronjob/<name of cronjob> <name of job>
