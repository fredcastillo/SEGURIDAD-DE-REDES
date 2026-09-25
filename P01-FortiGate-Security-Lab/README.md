# P01 — FortiGate Security Lab

![Security Networks](https://img.shields.io/badge/Subject-Network%20Security-1f6feb?style=flat-square)
![Platform](https://img.shields.io/badge/Lab-GNS3-7d5fff?style=flat-square)
![Firewall](https://img.shields.io/badge/Firewall-FortiGate-e11d48?style=flat-square)
![Status](https://img.shields.io/badge/Status-Documented%20Lab-success?style=flat-square)

> **Seguridad de Redes · GNS3 · FortiGate**

**Estudiante:** Fred Sneyder Castillo Apolinar  
**Matrícula:** 2025-2175  
**Docente:** Jonatan Rondon  

---

## 🎥 Video de demostración

**[▶ Ver video de demostración](VIDEO_URL)**

> Reemplazar `VIDEO_URL` por el enlace final de YouTube o OneDrive institucional. El video debe respetar el máximo de 10 minutos y mostrar fecha, hora, rostro y voz del estudiante.

---

## 🎯 Propósito del laboratorio

Este laboratorio implementa una infraestructura de **Seguridad de Redes** en GNS3 utilizando FortiGate como punto central de control entre un segmento de usuarios, un servidor web y un servidor de base de datos.

El objetivo es demostrar controles de seguridad funcionales, entre ellos:

- segmentación de red mediante VLAN 10 y subredes separadas;
- políticas de control de acceso entre usuarios y servidores;
- salida a Internet mediante NAT;
- control de acceso del WEB Server hacia la base de datos únicamente por TCP/3306;
- filtrado de descargas de archivos ejecutables `.exe`;
- protección frente a SYN flood mediante una política DoS/rate limiting;
- endurecimiento básico del switch;
- DHCP para el segmento de usuarios.

---

## 🏗️ Topología

![Topología principal](images/topology/topology.png)

La arquitectura utiliza un **FortiGate-VM64-KVM** como punto de control entre tres dominios principales:

| Segmento | Componente | Red | Función |
|---|---|---|---|
| Usuarios | VLAN 10 / Switch | `10.21.75.0/25` | Clientes del laboratorio |
| WEB | WEB-SERVER-LAB | `10.21.75.128/28` | Apache + PHP + HTTPS |
| DB | DB-SERVER-LAB | `10.21.75.144/28` | MariaDB |
| WAN | FortiGate port1 | DHCP | Acceso a Internet |

### Componentes

- **FortiGate-VM64-KVM v7.0.9 build0444** — firewall y punto de aplicación de políticas.
- **Cisco IOSvL2 15.2** — switch de acceso y VLAN 10.
- **PC1 (VPCS)** — cliente utilizado para verificar DHCP.
- **Browser-PC** — contenedor Docker con Debian y Firefox ESR para las pruebas desde navegador.
- **WEB-SERVER-LAB** — contenedor Docker con Ubuntu 22.04, Apache, PHP y HTTPS.
- **DB-SERVER-LAB** — contenedor Docker con Ubuntu 22.04 y MariaDB.

Los tres últimos componentes son **contenedores utilizados para simular los equipos y servidores solicitados por la práctica dentro de GNS3**.

---

## 🔐 Flujo de seguridad

![Flujo de tráfico](images/topology/traffic-flow.png)

El diseño fuerza a que el tráfico entre segmentos atraviese el FortiGate. El WEB Server y el DB Server utilizan puertos físicos separados del FortiGate, evitando que una comunicación entre ellos pueda escapar del control de las políticas mediante un mismo dominio de capa 2.

---

## ✅ Controles implementados y demostrados

| Control | Evidencia principal |
|---|---|
| Ruta por defecto | `images/fortigate/default-route.png` |
| NAT | `images/fortigate/policy-users-internet.png` |
| Usuarios → WEB | `images/fortigate/policy-users-web.png` |
| Usuarios → DB bloqueado | `images/tests/users-db-deny.png` |
| WEB → DB únicamente 3306 | `images/fortigate/policy-web-db-3306.png` |
| File Filter `.exe` | `images/tests/exe-block.png` |
| Rate limiting / SYN flood | `images/tests/dos-syn-flood-log.png` |
| VLAN 10 | `images/network/vlan10.png` |
| Seguridad básica del switch | `images/network/switch-security.png` |
| DHCP | `images/fortigate/dhcp-port2.png` + `images/containers/pc1-dhcp.png` |

---

## 📚 Documentación

| Documento | Contenido |
|---|---|
| [01 — Laboratorio](docs/01-laboratorio.md) | Propósito, objetivos, alcance e infraestructura. |
| [02 — Topología y arquitectura](docs/02-topologia-y-arquitectura.md) | Topología, direccionamiento, VLAN, interfaces y flujo de tráfico. |
| [03 — Configuración y seguridad](docs/03-configuracion-y-seguridad.md) | Configuración principal del FortiGate, switch y servicios. |
| [04 — Pruebas y cumplimiento](docs/04-pruebas-y-cumplimiento.md) | Pruebas funcionales, resultados y evidencias. |

English documentation is available using the same filenames with the `-EN` suffix.

---

## ⚙️ Archivos técnicos

### Configuraciones

```text
files/configs/
├── fortigate/
└── switch/
```

### Scripts

```text
files/scripts/
├── build-web-server.sh
├── build-db-server.sh
└── build-browser-gns3vnc.sh
```

Los scripts Docker se utilizan para reproducir los contenedores de laboratorio documentados en la práctica.

---

## 🖼️ Evidencias y diagramas

Todas las capturas se organizan por función:

```text
images/
├── topology/
├── fortigate/
├── network/
├── containers/
└── tests/
```

Los documentos ya contienen las rutas Markdown de cada evidencia. **No necesitas editar el MD cuando agregues una captura**, siempre que uses exactamente el nombre y la carpeta indicados: GitHub la renderizará automáticamente.

---

## 📦 Entrega

Archivo de entrega solicitado:

`submission/FredSneyderCastilloApolinar_2025-2175_P1.txt`

El archivo contiene el enlace del repositorio y el enlace del video final.

---

## 👤 Autor

**Fred Sneyder Castillo Apolinar**  
Matrícula **2025-2175**  
Materia **Seguridad de Redes**  
Docente **Jonatan Rondon**
