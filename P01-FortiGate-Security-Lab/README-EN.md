# P01 — FortiGate Security Lab

**Course:** Network Security  
**Student:** Fred Sneyder Castillo Apolinar  
**Student ID:** 2025-2175  
**Instructor:** Jonatan Rondon

---

## 🎥 Demonstration Video

> **Video:** `[INSERT YOUTUBE / ONEDRIVE LINK]`

The final demonstration must show the date and time, the student's face and voice, and focus on proving the operation of the topology and its security controls.

---

## 🎯 Purpose

Implement a **Network Security** laboratory in GNS3 centered on FortiGate, with segmentation between users and servers, access policies, NAT, file filtering, SYN flood mitigation, and network security controls.

The topology uses FortiGate as the central security point between the user, web server, and database server segments.

---

## 🏗️ Topology

![Lab topology](images/topology/topology.svg)

Main components:

- **FortiGate-VM64-KVM v7.0.9 build0444**
- **Cisco IOSvL2 15.2**
- **Browser-PC** — Docker container used as the client with Firefox.
- **WEB-SERVER-LAB** — Docker container running Apache, PHP, and HTTPS.
- **DB-SERVER-LAB** — Docker container running MariaDB.

> Browser-PC, WEB-SERVER-LAB, and DB-SERVER-LAB are containers used to simulate the devices and servers requested by the assignment.

---

## 📚 Documentation

| Document | Content |
|---|---|
| [01 — Laboratory](docs/01-laboratorio-EN.md) | Purpose, objectives, and infrastructure |
| [02 — Topology and architecture](docs/02-topologia-y-arquitectura-EN.md) | Network, addressing, VLAN, and traffic flow |
| [03 — Configuration and security](docs/03-configuracion-y-seguridad-EN.md) | Main configuration and security controls |
| [04 — Testing and compliance](docs/04-pruebas-y-cumplimiento-EN.md) | Requirement validation and evidence |

---

## ⚙️ Configurations and scripts

- `files/configs/fortigate/` — FortiGate configuration exports.
- `files/configs/switch/` — switch running-config and verification output.
- `files/scripts/` — scripts used to build the Docker images for the lab.

---

## 🖼️ Evidence

Screenshots and diagrams are organized under:

```text
images/
├── topology/
├── fortigate/
├── network/
├── containers/
└── tests/
```

Each document identifies where the corresponding evidence should be inserted.

---

## 📦 Submission

Required file:

`submission/FredSneyderCastilloApolinar_2025-2175_P1.txt`

---

## 👤 Author

**Fred Sneyder Castillo Apolinar**  
Network Security — 2026
