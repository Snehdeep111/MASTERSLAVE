#!/bin/bash
# === Update and Install MySQL Server ===
apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

# === Set MySQL root password ===
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'RootPass123!'; FLUSH PRIVILEGES;"

# === Enable binlog and configure master ===
cat >> /etc/mysql/mysql.conf.d/mysqld.cnf <<EOF

server-id=1
log_bin=/var/log/mysql/mysql-bin.log
bind-address=0.0.0.0
EOF

# === Restart MySQL service ===
systemctl restart mysql

# === Create replication user ===
mysql -uroot -pRootPass123! -e "CREATE USER 'replicator'@'%' IDENTIFIED WITH mysql_native_password BY 'SlavePass123!';"
mysql -uroot -pRootPass123! -e "GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';"
mysql -uroot -pRootPass123! -e "FLUSH PRIVILEGES;"
