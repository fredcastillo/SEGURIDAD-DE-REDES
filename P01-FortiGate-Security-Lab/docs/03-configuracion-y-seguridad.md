# 03 — Configuración y seguridad

## 3.1 Interfaces del FortiGate

Las interfaces utilizadas en la topología son:

- `port1`: DHCP / WAN.
- `port2`: `10.21.75.1/25` / Usuarios.
- `port3`: `10.21.75.129/28` / WEB.
- `port4`: `10.21.75.145/28` / DB.

El direccionamiento inicial de las interfaces se realizó por CLI únicamente para disponer de una interfaz con IP y poder acceder posteriormente a la GUI. La configuración operativa y los controles de seguridad del FortiGate se gestionaron desde la GUI.

> **[INSERTAR CAPTURA]** `images/fortigate/interfaces.png`  
> FortiGate → Network → Interfaces.

## 3.2 DHCP — red de Usuarios

En `port2` se configuró DHCP con:

- Range: `10.21.75.10` — `10.21.75.100`.
- Netmask: `255.255.255.128`.
- Default Gateway: same as interface IP.
- DNS: same as system DNS.

PC1 recibió `10.21.75.10/25` con gateway `10.21.75.1`.

> **[INSERTAR CAPTURA]** `images/fortigate/dhcp.png`  
> Configuración DHCP de `port2`.

> **[INSERTAR EVIDENCIA]** `images/network/pc1-dhcp.png`  
> `show ip all` de PC1.

## 3.3 Objetos de dirección

Se utilizaron objetos para representar los servidores:

- `WEB-Server` → `10.21.75.130/32`.
- `DB-Server` → `10.21.75.146/32`.

## 3.4 Ruta por defecto

Se creó manualmente la ruta:

`0.0.0.0/0.0.0.0 → port1`

El gateway numérico utilizado no se incluye aquí hasta que quede respaldado por la captura de la configuración final.

> **[INSERTAR CAPTURA]** `images/fortigate/default-route.png`  
> Network → Static Routes.

## 3.5 NAT y acceso a Internet

La política `Usuarios_a_Internet` permite salida desde `port2` hacia `port1` con NAT habilitado.

La conectividad se verificó mediante:

- `ping 8.8.8.8` desde Browser-PC.
- navegación a `example.com` desde el navegador.

> **[INSERTAR CAPTURA]** `images/fortigate/nat-policy.png`  
> Política `Usuarios_a_Internet` mostrando NAT habilitado.

> **[INSERTAR CAPTURA]** `images/tests/internet-access.png`  
> Evidencia de conectividad externa.

## 3.6 Usuarios → WEB

Política: `Usuarios_a_WEB`

- Incoming interface: `port2`.
- Outgoing interface: `port3`.
- Destination: `WEB-Server`.
- Servicio utilizado en las pruebas del laboratorio: HTTP/HTTPS según el estado del servicio.
- Acción: ACCEPT.

La prueba funcional realizada mediante `search.php?id=1` devolvió `1 - alice`.

> **[INSERTAR CAPTURA]** `images/fortigate/users-web-policy.png`  
> Política `Usuarios_a_WEB` completa.

> **[INSERTAR CAPTURA]** `images/tests/web-access.png`  
> Resultado del acceso desde Browser-PC.

## 3.7 Usuarios → DB

Política: `Usuarios_a_DB_BLOQUEADO`

- Incoming interface: `port2`.
- Outgoing interface: `port4`.
- Destination: `DB-Server`.
- Service: `MYSQL` / TCP 3306.
- Action: DENY.

La prueba a `10.21.75.146:3306` no estableció la conexión y el Forward Traffic log mostró `Deny: policy violation` asociado a la política.

> **[INSERTAR CAPTURA]** `images/tests/users-db-deny.png`

## 3.8 WEB → DB únicamente por 3306

Política: `WEB_a_DB_solo_3306`

- `port3 → port4`.
- `WEB-Server → DB-Server`.
- Servicio: `MYSQL` / TCP 3306.
- Acción: ACCEPT.

La comunicación por 3306 funcionó desde el servidor web. En la prueba negativa se comprobaron estos puertos desde WEB hacia DB y solo 3306 fue permitido:

`22, 80, 21, 23, 25, 53, 443, 3389, 3606, 8080`

> **[INSERTAR CAPTURA]** `images/tests/web-db-ports.png`  
> Evidencia de las pruebas positivas y negativas.

## 3.9 File Filter — bloqueo de `.exe`

Perfil: `Bloquear_EXE`

El perfil se aplicó a las políticas de salida utilizadas para la prueba.

La prueba definitiva utilizó un ejecutable Windows real:

`http://live.sysinternals.com/procexp.exe`

La descarga llegó aproximadamente al 99 % y terminó con:

`Recv failure: Connection reset by peer`

Este comportamiento confirmó el bloqueo en modo Flow-based después de que FortiGate identificara el tipo de archivo real.

> **[INSERTAR CAPTURA]** `images/fortigate/file-filter.png`  
> Perfil `Bloquear_EXE`.

> **[INSERTAR CAPTURA]** `images/tests/exe-block.png`  
> Log/evidencia del bloqueo de `procexp.exe`.

## 3.10 Rate Limiting / DoS

Política: `DoS_Anti_SYNFlood`

- Incoming interface: `port2`.
- Destination: `10.21.75.130`.
- Service: HTTPS.
- Anomaly: `tcp_syn_flood`.
- Action: Block.
- Threshold: `20`.

Prueba realizada:

```bash
hping3 -S -p 443 --flood 10.21.75.130
```

El log de Anomaly registró múltiples detecciones y sesiones con `clear_session`.

> **[INSERTAR CAPTURA]** `images/fortigate/dos-policy.png`  
> Configuración de `DoS_Anti_SYNFlood`.

> **[INSERTAR CAPTURA]** `images/tests/dos-detection.png`  
> Log de `tcp_syn_flood`.

## 3.11 Seguridad básica del switch

En VLAN 10 se aplicaron controles básicos de seguridad a los puertos de acceso utilizados:

- Port Security.
- Máximo de 1 MAC.
- Sticky MAC.
- Violación en modo restrict.
- BPDU Guard.
- `nonegotiate`.
- Puertos no utilizados en `shutdown`.

> **[INSERTAR CAPTURA]** `images/network/switch-security.png`  
> `show running-config` / estado de puertos.
