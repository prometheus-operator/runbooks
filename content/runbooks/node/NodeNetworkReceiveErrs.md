---
title: Node Network Receive Errors
weight: 20
---

# NodeNetworkReceiveErrs

## Meaning

Network interface is reporting many receive errors.

## Impact

Applications on the node may no longer be able to operate with other services.
Network attached storage performance issues or even data loss.

## Diagnosis

Investigate networkng issues on the node and to connected hardware.
Check physical cables, check networking firewall rules and so on.

## Mitigation

Cordon and drain node to migrate apps from it.
