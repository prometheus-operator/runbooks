---
title: Kube Job Failed
weight: 20
---

# KubeJobFailed

## Meaning

Job failed complete.

## Impact

Failure of processing of a scheduled task.

## Diagnosis

- Check job via `kubectl -n $NAMESPACE describe jobs $JOB`.
- Check pod events via `kubectl -n $NAMESPACE describe pod $POD_FROM_JOB`.
- Check pod logs via `kubectl -n $NAMESPACE log pod $POD_FROM_JOB`.

## Mitigation

- See [Debugging Pods](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/#debugging-pods)
- See [Job patterns](https://kubernetes.io/docs/tasks/job/)
- redesign job so that it is idempotent (can be re-run many times which will
  always produce the same output even if input differes)
