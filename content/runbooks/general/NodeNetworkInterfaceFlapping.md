---
title: Node Network Interface Flapping
weight: 20
---

# NodeNetworkInterfaceFlapping

## Meaning

Network interface is often changing its status

## Impact

Applications on the node may no longer be able to operate with other services.
Network attached storage performance issues or even data loss.

## Diagnosis

Investigate networking issues on the node and to connected hardware.
Check physical cables, check networking firewall rules and so on.

## Mitigation

Cordon and drain node to migrate apps from it.
