# 01 — Laboratory

## Academic information

| Field | Information |
|---|---|
| Student | Fred Sneyder Castillo Apolinar |
| Student ID | 2025-2175 |
| Course | Network Security |
| Instructor | Jonatan Rondon |
| Assignment | P01 — FortiGate Security Lab |
| Platform | GNS3 |

## Purpose

Build a laboratory topology where FortiGate acts as the central security control point between a user network, a web server, and a database server.

The laboratory demonstrates practical network security controls through verifiable configurations and tests performed from the lab nodes.

## Objectives

- Implement segmentation between users and servers.
- Configure connectivity and addressing based on the student's ID.
- Configure firewall policies and NAT.
- Restrict user access to the database server.
- Allow the web server to reach the database server only through port 3306.
- Implement filtering of `.exe` executable downloads.
- Implement and verify SYN flood protection through rate limiting/DoS policy.
- Configure VLAN 10 and basic switch security controls.
- Document the tests and collected evidence.

## Infrastructure

- FortiGate-VM64-KVM v7.0.9 build0444.
- Cisco IOSvL2 15.2.
- `Browser-PC`: Docker container with Debian and Firefox ESR.
- `WEB-SERVER-LAB`: Docker container with Ubuntu 22.04, Apache, PHP, and HTTPS.
- `DB-SERVER-LAB`: Docker container with Ubuntu 22.04 and MariaDB.

## Visual evidence

> **[INSERT IMAGE]** `images/topology/lab-overview.png`  
> General laboratory / GNS3 canvas view.

## Scope

This documentation focuses on the functional implementation and tests that form part of the assignment. Evidence is linked from the corresponding sections to maintain traceability between each requirement, its configuration, and its validation.
