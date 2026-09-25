# 03 — Configuration and security

## 3.1 FortiGate interfaces

Interfaces used by the topology:

- `port1`: DHCP / WAN.
- `port2`: `10.21.75.1/25` / Users.
- `port3`: `10.21.75.129/28` / WEB.
- `port4`: `10.21.75.145/28` / DB.

Initial interface addressing was performed through CLI only to give the FortiGate an IP address and make GUI access possible. Operational FortiGate configuration and security controls were managed through the GUI.

> **[INSERT SCREENSHOT]** `images/fortigate/interfaces.png`  
> FortiGate → Network → Interfaces.

## 3.2 DHCP — Users network

DHCP on `port2` was configured with:

- Range: `10.21.75.10` — `10.21.75.100`.
- Netmask: `255.255.255.128`.
- Default Gateway: same as interface IP.
- DNS: same as system DNS.

PC1 received `10.21.75.10/25` with gateway `10.21.75.1`.

> **[INSERT SCREENSHOT]** `images/fortigate/dhcp.png`  
> DHCP configuration for `port2`.

> **[INSERT EVIDENCE]** `images/network/pc1-dhcp.png`  
> PC1 `show ip all`.

## 3.3 Address objects

Address objects used for the servers:

- `WEB-Server` → `10.21.75.130/32`.
- `DB-Server` → `10.21.75.146/32`.

## 3.4 Default route

The following route was created manually:

`0.0.0.0/0.0.0.0 → port1`

The numeric gateway is not included here until it is backed by the final configuration screenshot.

> **[INSERT SCREENSHOT]** `images/fortigate/default-route.png`  
> Network → Static Routes.

## 3.5 NAT and Internet access

Policy `Usuarios_a_Internet` allows traffic from `port2` to `port1` with NAT enabled.

Connectivity was verified with:

- `ping 8.8.8.8` from Browser-PC.
- `example.com` navigation from the browser.

> **[INSERT SCREENSHOT]** `images/fortigate/nat-policy.png`  
> `Usuarios_a_Internet` showing NAT enabled.

> **[INSERT SCREENSHOT]** `images/tests/internet-access.png`  
> External connectivity evidence.

## 3.6 Users → WEB

Policy: `Usuarios_a_WEB`

- Incoming interface: `port2`.
- Outgoing interface: `port3`.
- Destination: `WEB-Server`.
- Service used during lab testing: HTTP/HTTPS depending on the current service state.
- Action: ACCEPT.

The functional `search.php?id=1` test returned `1 - alice`.

> **[INSERT SCREENSHOT]** `images/fortigate/users-web-policy.png`  
> Full `Usuarios_a_WEB` policy.

> **[INSERT SCREENSHOT]** `images/tests/web-access.png`  
> Browser-PC access result.

## 3.7 Users → DB

Policy: `Usuarios_a_DB_BLOQUEADO`

- Incoming interface: `port2`.
- Outgoing interface: `port4`.
- Destination: `DB-Server`.
- Service: `MYSQL` / TCP 3306.
- Action: DENY.

The connection attempt to `10.21.75.146:3306` did not establish and the Forward Traffic log showed `Deny: policy violation` for the policy.

> **[INSERT SCREENSHOT]** `images/tests/users-db-deny.png`

## 3.8 WEB → DB only through 3306

Policy: `WEB_a_DB_solo_3306`

- `port3 → port4`.
- `WEB-Server → DB-Server`.
- Service: `MYSQL` / TCP 3306.
- Action: ACCEPT.

Communication over 3306 worked from the web server. In the negative test, the following ports were checked from WEB to DB and only 3306 was allowed:

`22, 80, 21, 23, 25, 53, 443, 3389, 3606, 8080`

> **[INSERT SCREENSHOT]** `images/tests/web-db-ports.png`  
> Positive and negative test evidence.

## 3.9 File Filter — `.exe` blocking

Profile: `Bloquear_EXE`

The profile was attached to the policies used for the test.

The definitive test used a real Windows executable:

`http://live.sysinternals.com/procexp.exe`

The transfer reached approximately 99% and ended with:

`Recv failure: Connection reset by peer`

This behavior confirmed Flow-based blocking after FortiGate identified the actual file type.

> **[INSERT SCREENSHOT]** `images/fortigate/file-filter.png`  
> `Bloquear_EXE` profile.

> **[INSERT SCREENSHOT]** `images/tests/exe-block.png`  
> Block log/evidence for `procexp.exe`.

## 3.10 Rate Limiting / DoS

Policy: `DoS_Anti_SYNFlood`

- Incoming interface: `port2`.
- Destination: `10.21.75.130`.
- Service: HTTPS.
- Anomaly: `tcp_syn_flood`.
- Action: Block.
- Threshold: `20`.

Test command:

```bash
hping3 -S -p 443 --flood 10.21.75.130
```

The Anomaly log recorded multiple detections and sessions with `clear_session`.

> **[INSERT SCREENSHOT]** `images/fortigate/dos-policy.png`  
> `DoS_Anti_SYNFlood` configuration.

> **[INSERT SCREENSHOT]** `images/tests/dos-detection.png`  
> `tcp_syn_flood` log.

## 3.11 Basic switch security

Basic security controls were applied to the VLAN 10 access ports:

- Port Security.
- Maximum 1 MAC address.
- Sticky MAC.
- Restrict violation mode.
- BPDU Guard.
- `nonegotiate`.
- Unused ports shut down.

> **[INSERT SCREENSHOT]** `images/network/switch-security.png`  
> `show running-config` / port status.
