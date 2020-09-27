#!/bin/bash
set -x
mysql -u root <<MYSQL_SCRIPT
CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';
CREATE DATABASE wikidatabase; 
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';
FLUSH PRIVILEGES; 
SHOW DATABASES; 
SHOW GRANTS FOR 'wiki'@'localhost';
exit
MYSQL_SCRIPT