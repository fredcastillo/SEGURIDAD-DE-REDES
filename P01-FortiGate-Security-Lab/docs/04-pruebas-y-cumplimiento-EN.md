# 04 — Testing and compliance

## Validation matrix

| Requirement | Implementation | Test | Status |
|---|---|---|---|
| Default route | `0.0.0.0/0` via `port1` | `ping 8.8.8.8` + browsing | ✅ Verified |
| NAT | `Usuarios_a_Internet` | Internet access | ✅ Verified |
| Users → WEB | `Usuarios_a_WEB` | `search.php?id=1` | ✅ Verified |
| Users → DB blocked | `Usuarios_a_DB_BLOQUEADO` | 3306 attempt + log | ✅ Verified |
| WEB → DB only 3306 | `WEB_a_DB_solo_3306` | Positive test + 10 negative ports | ✅ Verified |
| `.exe` File Filter | `Bloquear_EXE` | `procexp.exe` download | ✅ Verified |
| Rate limiting / DoS | `DoS_Anti_SYNFlood` | `hping3` SYN flood | ✅ Verified |
| VLAN 10 | `USERS` | `show vlan brief` | ✅ Verified |
| Basic switch security | Port Security + BPDU Guard + nonegotiate + shutdown | `show running-config` / `show interfaces status` | ✅ Verified |
| /28 servers | WEB + DB containers | Apache / MariaDB tests | ✅ Verified |
| /25 users + DHCP | DHCP on `port2` | `ip dhcp` + `show ip all` | ✅ Verified |

## Key tests

### 1. Internet access

Browser-PC reached `8.8.8.8` and browsed to `example.com` after route and NAT configuration.

> **[INSERT SCREENSHOT]** `images/tests/internet-access.png`

### 2. Users → DB blocked

Access to `10.21.75.146:3306` was denied and logged as `Deny: policy violation`.

> **[INSERT SCREENSHOT]** `images/tests/users-db-deny.png`

### 3. WEB → DB restricted

`3306` worked for the application, while the ten additional tested ports were blocked.

Negative ports:

`22, 80, 21, 23, 25, 53, 443, 3389, 3606, 8080`

> **[INSERT SCREENSHOT]** `images/tests/web-db-ports.png`

### 4. File Filter

The real `procexp.exe` file transfer was interrupted with `Connection reset by peer`.

> **[INSERT SCREENSHOT]** `images/tests/exe-block.png`

### 5. SYN flood

`DoS_Anti_SYNFlood` detected and blocked excessive sessions. The log showed multiple `tcp_syn_flood` events with `clear_session`.

> **[INSERT SCREENSHOT]** `images/tests/dos-detection.png`

## Additional evidence

> **[INSERT SCREENSHOT]** `images/fortigate/default-route.png`  
> Default route.

> **[INSERT SCREENSHOT]** `images/fortigate/nat-policy.png`  
> NAT.

> **[INSERT SCREENSHOT]** `images/fortigate/dhcp.png`  
> User DHCP.

> **[INSERT SCREENSHOT]** `images/network/vlan10.png`  
> VLAN 10.

> **[INSERT SCREENSHOT]** `images/network/switch-security.png`  
> Basic switch security.
