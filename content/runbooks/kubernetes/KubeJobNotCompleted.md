---
title: Kube Job Not Completed
weight: 20
---

# KubeJobNotCompleted

## Meaning

Job is taking more than 12h to complete.

## Impact

- Long processing of batch jobs.
- Possible issues with scheduling next Job

## Diagnosis

- Check job via `kubectl -n $NAMESPACE describe jobs $JOB`.
- Check the pod logs using `kubectl -n $NAMESPACE logs $POD_FROM_JOB` for further information.

## Mitigation

- Give it more resources so it finishes faster, if applicable.
- See [Job patterns](https://kubernetes.io/docs/tasks/job/)
