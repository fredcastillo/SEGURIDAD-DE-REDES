# P01 — FortiGate Security Lab

**Materia:** Seguridad de Redes  
**Estudiante:** Fred Sneyder Castillo Apolinar  
**Matrícula:** 2025-2175  
**Docente:** Jonatan Rondon

---

## 🎥 Video de demostración

> **Video:** `[INSERTAR ENLACE DE YOUTUBE / ONEDRIVE]`

La demostración final debe mostrar fecha y hora, rostro y voz del estudiante, y centrarse en comprobar el funcionamiento de la topología y sus controles de seguridad.

---

## 🎯 Propósito

Implementar en GNS3 un laboratorio de **Seguridad de Redes** centrado en FortiGate, con segmentación entre usuarios y servidores, políticas de acceso, NAT, filtrado de archivos, mitigación de SYN flood y controles de seguridad de red.

La topología utiliza un FortiGate como punto central de control entre los segmentos de usuarios, servidor web y servidor de base de datos.

---

## 🏗️ Topología

![Topología del laboratorio](images/topology/gns3-topology.png)

Componentes principales:

- **FortiGate-VM64-KVM v7.0.9 build0444**
- **Cisco IOSvL2 15.2**
- **Browser-PC** — contenedor Docker utilizado como cliente con Firefox.
- **WEB-SERVER-LAB** — contenedor Docker con Apache, PHP y HTTPS.
- **DB-SERVER-LAB** — contenedor Docker con MariaDB.

> Browser-PC, WEB-SERVER-LAB y DB-SERVER-LAB son contenedores utilizados para simular los equipos y servidores solicitados en la práctica.

---

## 📚 Documentación

| Documento | Contenido |
|---|---|
| [01 — Laboratorio](docs/01-laboratorio.md) | Propósito, objetivos e infraestructura |
| [02 — Topología y arquitectura](docs/02-topologia-y-arquitectura.md) | Red, direccionamiento, VLAN y flujo |
| [03 — Configuración y seguridad](docs/03-configuracion-y-seguridad.md) | Configuración principal y controles |
| [04 — Pruebas y cumplimiento](docs/04-pruebas-y-cumplimiento.md) | Verificación de requisitos y evidencias |

English versions are available with the `-EN` suffix.

---

## ⚙️ Configuraciones y scripts

- `files/configs/fortigate/` — exportaciones de configuración del FortiGate.
- `files/configs/switch/` — running-config y verificaciones del switch.
- `files/scripts/` — scripts utilizados para construir las imágenes Docker del laboratorio.

---

## 🖼️ Evidencias

Las capturas y diagramas se organizan en:

```text
images/
├── topology/
├── fortigate/
├── network/
├── containers/
└── tests/
```

Cada documento identifica el lugar donde debe incorporarse la evidencia correspondiente.

---

## 📦 Entrega

Archivo solicitado por el docente:

`submission/FredSneyderCastilloApolinar_2025-2175_P1.txt`

---

## 👤 Autor

**Fred Sneyder Castillo Apolinar**  
Seguridad de Redes — 2026
