---
title: Node Clock Skew Detected
weight: 20
---

# NodeClockSkewDetected

## Meaning

Clock skew detected.

## Impact

Node instability, apps disconencting.

## Diagnosis

TODO

## Mitigation

Ensure time synchronization service is running.
Set proper time servers.
Esure to sync time on server start, especially when using
low power mode or hibernation.

Some resource consuming process can cause issues on given hardware,
so move it to different servers.

On physical servers check if on-board battery requires replacement.
Check for hardware errors.
Check for firmware updates.
Ensure to use newer hardware (like server mainboard and so on).
