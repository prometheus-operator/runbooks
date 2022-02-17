---
title: Kube Job Completion
weight: 20
---

# KubeJobCompletion

## Meaning

Job is taking more than 1h to complete.

## Impact

Just delayed processing of batch jobs.

## Diagnosis

Check the job using kubectl describe job <job> and look at the pod logs using kubectl logs <pod> for further information.

- Check job via `kubectl -n $NAMESPACE describe jobs $JOB`.
- Check pod events via `kubectl -n $NAMESPACE describe job $JOB`.

## Mitigation

- Give it more resources so it finishes faster, if applicable.
- See [Job patterns](https://kubernetes.io/docs/tasks/job/)
