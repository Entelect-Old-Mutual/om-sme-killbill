#!/bin/bash
set -e

# Create Kaui database
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS kaui;"
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON kaui.* TO '${MYSQL_USER}'@'%';"

# Create KillBill user if it doesn't exist
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "
USE killbill;
CREATE TABLE IF NOT EXISTS users (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(128) NOT NULL,
  password varchar(128) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY users_username (username)
);
INSERT IGNORE INTO users (username, password) VALUES ('admin', 'password');
"

echo "Database initialization completed"