# 04 — Pruebas y cumplimiento

## Matriz de validación

| Requisito | Implementación | Prueba | Estado |
|---|---|---|---|
| Ruta por defecto | `0.0.0.0/0` vía `port1` | `ping 8.8.8.8` + navegación | ✅ Verificado |
| NAT | `Usuarios_a_Internet` | Salida a Internet | ✅ Verificado |
| Usuarios → WEB | `Usuarios_a_WEB` | `search.php?id=1` | ✅ Verificado |
| Usuarios → DB bloqueado | `Usuarios_a_DB_BLOQUEADO` | Intento a 3306 + log | ✅ Verificado |
| WEB → DB solo 3306 | `WEB_a_DB_solo_3306` | Prueba positiva + 10 puertos negativos | ✅ Verificado |
| File Filter `.exe` | `Bloquear_EXE` | Descarga de `procexp.exe` | ✅ Verificado |
| Rate limiting / DoS | `DoS_Anti_SYNFlood` | `hping3` SYN flood | ✅ Verificado |
| VLAN 10 | `USERS` | `show vlan brief` | ✅ Verificado |
| Seguridad básica del switch | Port Security + BPDU Guard + nonegotiate + shutdown | `show running-config` / `show interfaces status` | ✅ Verificado |
| Servidores /28 | WEB + DB containers | Apache / MariaDB tests | ✅ Verificado |
| Usuarios /25 + DHCP | DHCP en `port2` | `ip dhcp` + `show ip all` | ✅ Verificado |

## Pruebas destacadas

### 1. Salida a Internet

Browser-PC logró alcanzar `8.8.8.8` y navegar a `example.com` después de la configuración de la ruta y NAT.

> **[INSERTAR CAPTURA]** `images/tests/internet-access.png`

### 2. Usuarios → DB bloqueado

El acceso a `10.21.75.146:3306` fue denegado y quedó registrado como `Deny: policy violation`.

> **[INSERTAR CAPTURA]** `images/tests/users-db-deny.png`

### 3. WEB → DB restringido

`3306` funcionó para la aplicación y los diez puertos adicionales comprobados fueron bloqueados.

Puertos negativos:

`22, 80, 21, 23, 25, 53, 443, 3389, 3606, 8080`

> **[INSERTAR CAPTURA]** `images/tests/web-db-ports.png`

### 4. File Filter

El archivo real `procexp.exe` se interrumpió con `Connection reset by peer` durante la transferencia.

> **[INSERTAR CAPTURA]** `images/tests/exe-block.png`

### 5. SYN flood

La política `DoS_Anti_SYNFlood` detectó y bloqueó las sesiones en exceso. El log mostró múltiples eventos `tcp_syn_flood` con `clear_session`.

> **[INSERTAR CAPTURA]** `images/tests/dos-detection.png`

## Evidencia complementaria

> **[INSERTAR CAPTURA]** `images/fortigate/default-route.png`  
> Ruta por defecto.

> **[INSERTAR CAPTURA]** `images/fortigate/nat-policy.png`  
> NAT.

> **[INSERTAR CAPTURA]** `images/fortigate/dhcp.png`  
> DHCP de Usuarios.

> **[INSERTAR CAPTURA]** `images/network/vlan10.png`  
> VLAN 10.

> **[INSERTAR CAPTURA]** `images/network/switch-security.png`  
> Seguridad básica del switch.
