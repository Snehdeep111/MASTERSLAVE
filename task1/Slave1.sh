#!/bin/bash
# Update & Install MySQL
sudo apt update -y
sudo apt install mysql-server -y

# Backup default MySQL config
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.backup

# Set replication slave configs
sudo bash -c 'cat > /etc/mysql/mysql.conf.d/mysqld.cnf <<EOF
[mysqld]
server-id = 2
relay-log = /var/log/mysql/mysql-relay-bin.log
read_only = 1

user            = mysql
bind-address    = 0.0.0.0
mysqlx-bind-address = 127.0.0.1
EOF'

# Restart MySQL to apply changes
sudo systemctl restart mysql

# Enable MySQL on boot
sudo systemctl enable mysql

# Allow root login (optional: secure this)
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'RootPass123!'; FLUSH PRIVILEGES;"

CHANGE MASTER TO
  MASTER_HOST='MASTER_PRIVATE_IP',
  MASTER_USER='replicator',
  MASTER_PASSWORD='SlavePass123!',
  MASTER_LOG_FILE='mysql-bin.000003',
  MASTER_LOG_POS=779;
START SLAVE;

SHOW SLAVE STATUS\G;
