# MASTERSLAVE
MASTER SLAVE REPLICATION USING AWS AND BASH SCRIPT
# 🗃️ Master-Slave MySQL Replication on AWS (with Bash Automation)

This project sets up **MySQL Master-Slave replication** using **AWS EC2 instances**, automated with **User Data scripts** and **Bash scripting**. It demonstrates a scalable, read-only replica system for real-time MySQL data synchronization.

---

## 📌 Project Overview

- ✅ 1 Master EC2 Instance (MySQL Master Server)
- ✅ 2 Slave EC2 Instances (MySQL Replica Servers)
- ✅ Automated setup using EC2 User Data and Bash
- ✅ Real-time binlog-based replication from master to slaves
- ✅ Read-only restriction enforced on slave nodes

---

## 🛠️ Technologies Used

- AWS EC2
- Ubuntu 24.04 LTS
- MySQL 8.0
- Bash Script (for automation)
- SSH & .pem Key Authentication
- User Data Scripts (for instance provisioning)

---

## 🔁 Replication Topology

      ┌────────────┐
      │   MASTER   │
      │  (Writer)  │
      └─────┬──────┘
            │
   ┌────────▼────────┐
   │                 │
┌─────▼────┐ ┌─────▼────┐
│ SLAVE 1 │ │ SLAVE 2 │
│ (Reader) │ │ (Reader) │
└──────────┘ └──────────┘


---

## 🧪 Features

- ✅ MySQL binlog replication
- ✅ Slaves auto-follow master changes
- ✅ `read_only=1` enforced on slaves
- ✅ Connection via private IP using common security group
- ✅ Fully automated bootstrapping using User Data

---

## 📂 Files Included

- `master-user-data.sh` — Startup script for Master instance
- `slave1-user-data.sh` — Startup script for Slave 1
- `slave2-user-data.sh` — Startup script for Slave 2
- `bash-deployment-script.sh` — Optional script to deploy MySQL and configure replication manually (bonus)

---

## ✅ Testing Instructions

### 1. Verify Replication

- SSH into **Master** and run:

```sql
USE replicate_test;
INSERT INTO demo VALUES (999, 'Testing replication');
INSERT INTO demo VALUES (1001, 'Try writing from slave');
| Rule         | Type | Protocol | Port Range                 | Source |
| ------------ | ---- | -------- | -------------------------- | ------ |
| SSH          | TCP  | 22       | 0.0.0.0/0                  |        |
| MySQL/Aurora | TCP  | 3306     | Custom (Security Group ID) |        |
| HTTP         | TCP  | 80       | 0.0.0.0/0                  |        |

⚠️ Notes
Ensure port 3306 is open in the security group.

bind-address = 0.0.0.0 must be set in /etc/mysql/mysql.conf.d/mysqld.cnf on Master.

Replication user must use mysql_native_password authentication plugin.
🙌 Author
Snehdeep Bansod
👨‍💻 Final-year CSE Student
📍 GCOE Amravati
📬 Contact: [deepbansod111@gmail.com]


