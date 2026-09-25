# 01 — Laboratorio

## Información académica

| Campo | Información |
|---|---|
| Estudiante | Fred Sneyder Castillo Apolinar |
| Matrícula | 2025-2175 |
| Materia | Seguridad de Redes |
| Docente | Jonatan Rondon |
| Práctica | P01 — FortiGate Security Lab |
| Plataforma | GNS3 |

## Propósito

Construir una topología de laboratorio donde el FortiGate actúe como punto central de control de seguridad entre una red de usuarios, un servidor web y un servidor de base de datos.

El laboratorio busca demostrar controles prácticos de seguridad de red mediante configuraciones verificables y pruebas desde los nodos del entorno.

## Objetivos

- Implementar la segmentación entre usuarios y servidores.
- Configurar conectividad y direccionamiento conforme a la matrícula.
- Configurar políticas de firewall y NAT.
- Restringir el acceso de Usuarios hacia el servidor de base de datos.
- Permitir que el servidor web acceda al servidor de base de datos únicamente por el puerto 3306.
- Implementar filtrado de archivos ejecutables `.exe`.
- Implementar y verificar protección contra SYN flood mediante rate limiting/DoS policy.
- Configurar VLAN 10 y controles básicos de seguridad en el switch.
- Documentar las pruebas y evidencias obtenidas.

## Infraestructura

- FortiGate-VM64-KVM v7.0.9 build0444.
- Cisco IOSvL2 15.2.
- `Browser-PC`: contenedor Docker con Debian y Firefox ESR.
- `WEB-SERVER-LAB`: contenedor Docker con Ubuntu 22.04, Apache, PHP y HTTPS.
- `DB-SERVER-LAB`: contenedor Docker con Ubuntu 22.04 y MariaDB.

## Evidencia visual

> **[INSERTAR IMAGEN]** `images/topology/lab-overview.png`  
> Vista general del laboratorio / canvas de GNS3.

## Alcance

La documentación se centra en la implementación funcional y las pruebas que forman parte de la entrega de la práctica. Las evidencias se enlazan desde los apartados correspondientes para mantener trazabilidad entre requisito, configuración y prueba.
