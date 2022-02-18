---
title: Kube Job Completion
weight: 20
---

# KubeJobCompletion

## Meaning

Job is taking more than 1h to complete.

## Impact

- Long processing of batch jobs.
- Possible issues with scheduling next Job

## Diagnosis

- Check job via `kubectl -n $NAMESPACE describe jobs $JOB`.
- Check pod events via `kubectl -n $NAMESPACE describe job $JOB`.

## Mitigation

- Give it more resources so it finishes faster, if applicable.
- See [Job patterns](https://kubernetes.io/docs/tasks/job/)
