---
title: Kube Persistent Volume Errors
weight: 20
---

# KubePersistentVolumeErrors

## Meaning

PersistentVolume is having issues with provisioning.
Volue may be unavailable or have data erors (corrupted storage).

## Impact

Service degradation, data loss.

## Diagnosis

Check storage provider for logs.
Check storage quotas in the cloud.

## Mitigation

In happy scenario storage is just not provisioned as fast as expected.
In worst scenario there is data corruption or data loss. Restore from backup.