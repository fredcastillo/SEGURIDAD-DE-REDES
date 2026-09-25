# 02 — Topology and architecture

## Topology

> **[INSERT FINAL DIAGRAM]** `images/topology/topology.png`  
> Final topology PNG.

![Topology](../images/topology/topology.svg)

### Components

- **FortiGate-VM64-KVM**: central routing and security control point.
- **Cisco IOSvL2**: user-network connectivity and VLAN 10.
- **Browser-PC**: client with a real browser for testing.
- **WEB-SERVER-LAB**: Apache/PHP web server with HTTPS.
- **DB-SERVER-LAB**: MariaDB database server.

`WEB-SERVER-LAB` and `DB-SERVER-LAB` are connected to dedicated FortiGate physical interfaces so WEB → DB traffic must traverse the firewall.

## Addressing

| Device | Interface | Address | Prefix | Gateway | Role |
|---|---|---:|---:|---:|---|
| FortiGate | port1 | DHCP | — | — | WAN / Internet |
| FortiGate | port2 | 10.21.75.1 | /25 | — | Users |
| FortiGate | port3 | 10.21.75.129 | /28 | — | WEB |
| FortiGate | port4 | 10.21.75.145 | /28 | — | DB |
| PC1 | eth0 | 10.21.75.10 | /25 | 10.21.75.1 | User / DHCP |
| Browser-PC | eth0 | 10.21.75.110 | /25 | 10.21.75.1 | Test client |
| WEB-SERVER-LAB | eth0 | 10.21.75.130 | /28 | 10.21.75.129 | Apache + PHP + HTTPS |
| DB-SERVER-LAB | eth0 | 10.21.75.146 | /28 | 10.21.75.145 | MariaDB |

## VLAN 10 — USERS

The user network uses **VLAN 10**, named `USERS`.

Configured access ports:

- `Gi0/0` → FortiGate `port2`.
- `Gi0/1` → PC1.
- `Gi0/2` → Browser-PC.

The remaining switch ports are disabled.

> **[INSERT SCREENSHOT]** `images/network/vlan10.png`  
> `show vlan brief` showing VLAN 10 and its ports.

## Main traffic flow

> **[INSERT DIAGRAM]** `images/topology/traffic-flow.png`

Expected flow:

`Browser-PC → FortiGate → destination`

and for web-to-database access:

`WEB-SERVER-LAB → FortiGate → DB-SERVER-LAB : 3306`

## Evidence

> **[INSERT SCREENSHOT]** `images/topology/gns3-canvas.png`  
> Full GNS3 canvas with all nodes and links visible.
