# TP5 : Self-hosted cloud
## Partie 1 : Mise en place et maîtrise du serveur Web
## 1. Installation
### 🌞 Installer le serveur Apache 🌞
```
[john@db ~]$ sudo dnf install httpd
```

### 🌞 Démarrer le service Apache 🌞

```
[john@db ~]$ sudo systemctl start httpd
[john@db ~]$ sudo systemctl enable httpd
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
[john@db ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; ve>
     Active: active (running) since Tue 2023-01-03 15:14:05 CET; 21s ago
       Docs: man:httpd.service(8)
   Main PID: 38460 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: >
      Tasks: 213 (limit: 5904)
     Memory: 25.1M
        CPU: 111ms
     CGroup: /system.slice/httpd.service
             ├─38460 /usr/sbin/httpd -DFOREGROUND
             ├─38461 /usr/sbin/httpd -DFOREGROUND
             ├─38462 /usr/sbin/httpd -DFOREGROUND
             ├─38463 /usr/sbin/httpd -DFOREGROUND
             └─38464 /usr/sbin/httpd -DFOREGROUND

Jan 03 15:14:05 db.localdomain systemd[1]: Starting The Apache H>
Jan 03 15:14:05 db.localdomain httpd[38460]: AH00558: httpd: Cou>
Jan 03 15:14:05 db.localdomain httpd[38460]: Server configured, >
Jan 03 15:14:05 db.localdomain systemd[1]: Started The Apache HT>
[john@db ~]$ sudo systemctl is-enabled httpd
[sudo] password for john:
enabled
[john@db ~]$ sudo ss -lantpu | grep httpd
tcp   LISTEN 0      511                   *:80              *:*     users:(("httpd",pid=1618,fd=4),("httpd",pid=1617,fd=4),("httpd",pid=1616,fd=4),("httpd",pid=1614,fd=4))
[john@db ~]$ sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
success
[john@db ~]$ sudo firewall-cmd --reload
success
```

### 🌞 TEST 🌞

```
ozoux@Guillaume MINGW64 ~
$ curl http://10.105.1.11/ |head -10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

100  7620  100  7620    0     0  1207k      0 --:--:-- --:--:-- --:--:-- 1488k      html {

```

## 2. Avancer vers la maîtrise du service
### 🌞 Le service Apache... 🌞

```
[john@db ~]$ cd /etc
[john@db etc]$ systemctl cat httpd | tail -10
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true
OOMPolicy=continue

[Install]
WantedBy=multi-user.target
```

### 🌞 Déterminer sous quel utilisateur tourne le processus Apache 🌞

```
[john@db ~]$ sudo cat /etc/httpd/conf/httpd.conf | grep apache
[sudo] password for john:
User apache
Group apache
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
[john@db httpd]$ ps -ef | grep httpd
root        1614       1  0 12:05 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1615    1614  0 12:05 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1616    1614  0 12:05 ?        00:00:02 /usr/sbin/httpd -DFOREGROUND
apache      1617    1614  0 12:05 ?        00:00:02 /usr/sbin/httpd -DFOREGROUND
apache      1618    1614  0 12:05 ?        00:00:02 /usr/sbin/httpd -DFOREGROUND
john        1916    1281  0 12:37 pts/0    00:00:00 grep --color=auto httpd
[john@db httpd]$ cd /usr/share/testpage/
[john@db testpage]$ ls -al
total 12
drwxr-xr-x.  2 root root   24 Jan 17 12:02 .
drwxr-xr-x. 83 root root 4096 Jan 17 12:02 ..
-rw-r--r--.  1 root root 7620 Jul 27 20:05 index.html
```

### 🌞 Changer l'utilisateur utilisé par Apache 🌞

```
[john@db ~]$ sudo useradd guillaume -s /sbin/nologin -u 6969 -d /usr/share/httpd -p root
[john@db ~]$ sudo cat /etc/passwd | tail -2
apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
guillaume:x:6969:6969::/usr/share/httpd:/sbin/nologin
[john@db ~]$ sudo cat /etc/httpd/conf/httpd.conf | grep guillaume
User guillaume
Group guillaume
[john@db /]$ sudo systemctl restart httpd
[john@db /]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Thu 2023-01-26 16:18:49 CET; 14s ago
       Docs: man:httpd.service(8)
   Main PID: 1604 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 213 (limit: 4636)
     Memory: 24.9M
        CPU: 101ms
     CGroup: /system.slice/httpd.service
             ├─1604 /usr/sbin/httpd -DFOREGROUND
             ├─1606 /usr/sbin/httpd -DFOREGROUND
             ├─1607 /usr/sbin/httpd -DFOREGROUND
             ├─1608 /usr/sbin/httpd -DFOREGROUND
             └─1609 /usr/sbin/httpd -DFOREGROUND

Jan 26 16:18:49 db.localdomain systemd[1]: Starting The Apache HTTP Server...
Jan 26 16:18:49 db.localdomain httpd[1604]: AH00558: httpd: Could not reliably determine the server's fully qualified domain >
Jan 26 16:18:49 db.localdomain httpd[1604]: Server configured, listening on: port 80
Jan 26 16:18:49 db.localdomain systemd[1]: Started The Apache HTTP Server.
[john@db /]$ ps -ef | grep guillaume
guillaume      1488    1487  0 09:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
guillaume      1489    1487  0 09:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
guillaume      1490    1487  0 09:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
guillaume      1491    1487  0 09:16 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
john    1706    1410  0 09:17 pts/0    00:00:00 grep --color=auto guillaume
```

### 🌞 Faites en sorte que Apache tourne sur un autre port 🌞

```
[john@db /]$ sudo cat /etc/httpd/conf/httpd.conf | grep Listen
Listen 8080
[john@db /]$ sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
success
[john@db /]$ sudo firewall-cmd --reload
success
[john@db /]$ sudo systemctl restart httpd
[john@db /]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; ve>
     Active: active (running) since Mon 2023-01-09 09:21:51 CET; 5s ago
       Docs: man:httpd.service(8)
   Main PID: 1741 (httpd)
     Status: "Started, listening on: port 8080"
      Tasks: 213 (limit: 4631)
     Memory: 22.9M
        CPU: 43ms
     CGroup: /system.slice/httpd.service
             ├─1741 /usr/sbin/httpd -DFOREGROUND
             ├─1743 /usr/sbin/httpd -DFOREGROUND
             ├─1744 /usr/sbin/httpd -DFOREGROUND
             ├─1745 /usr/sbin/httpd -DFOREGROUND
             └─1746 /usr/sbin/httpd -DFOREGROUND

Jan 09 09:21:51 db.localdomain systemd[1]: Starting The Apache H>
Jan 09 09:21:51 db.localdomain httpd[1741]: AH00558: httpd: Coul>
Jan 09 09:21:51 db.localdomain httpd[1741]: Server configured, l>
Jan 09 09:21:51 db.localdomain systemd[1]: Started The Apache HT>
lines 1-20/20 (END)
[john@db /]$ sudo ss -lnaptu | grep 8080
tcp   LISTEN 0      511                   *:8080            *:*     users:(("httpd",pid=1746,fd=4),("httpd",pid=1745,fd=4),("httpd",pid=1744,fd=4),("httpd",pid=1741,fd=4))
[john@db /]$curl db:8080 | head -10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--100  7620  100  7620    0     0  1488k      0 --:--:-- --:--:-- --:--:-- 1488k
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
guillaume@LAPTOP-GEJ2DKFJ MINGW64 ~
$ curl 10.105.1.11:8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
        height: 100%;
        width: 100%;
      }
        body {
```
Fichier [/etc/httpd/conf/httpd.conf](httpd.conf)

# Partie 2 : Mise en place et maîtrise du serveur de base de données

### 🌞 Install de MariaDB sur db.tp5.linux 🌞

```
[john@db ~]$ sudo dnf install mariadb-server
[...]
Complete!
[john@db ~]$ sudo systemctl enable mariadb
Created symlink /etc/systemd/system/mysql.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/mysqld.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/multi-user.target.wants/mariadb.service → /usr/lib/systemd/system/mariadb.service.
[john@db ~]$ sudo systemctl start mariadb
[john@db ~]$ sudo mysql_secure_installation
[john@db ~]$ sudo systemctl is-enabled mariadb
enabled
```

### 🌞 Port utilisé par MariaDB 🌞

```
[john@db ~]$ ss -lnaptu | grep 3306
tcp   LISTEN 0      80                    *:3306            *:*
[john@db ~]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
[john@db ~]$ sudo firewall-cmd --reload
success
[john@db ~]$ sudo ps -ef | grep mariadb
mysql      35537       1  0 09:51 ?        00:00:00 /usr/libexec/mariad
d --basedir=/usr
john   35745     926  0 10:47 pts/0    00:00:00 grep --color=auto mariadb
```

# Partie 3 : Configuration et mise en place de NextCloud
## 1. Base de données

### 🌞 Préparation de la base pour NextCloud 🌞

```
[john@db ~]$ sudo mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 15
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'nextcloud'@'10.105.1.11' IDENTIFIED BY 'pewpewpew';
Query OK, 0 rows affected (0.002 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'10.105.1.11';
Query OK, 0 rows affected (0.003 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)
```

### 🌞 Exploration de la base de données 🌞

```
[john@web ~]$ dnf provides mysql
Rocky Linux 9 - BaseOS                  1.3 MB/s | 1.7 MB     00:01
Rocky Linux 9 - AppStream               6.8 MB/s | 6.4 MB     00:00
Rocky Linux 9 - Extras                   17 kB/s | 8.5 kB     00:00
mysql-8.0.30-3.el9_0.x86_64 : MySQL client programs and shared libraries
Repo        : appstream
Matched from:
Provide    : mysql = 8.0.30-3.el9_0
[john@web ~]$ mysql -u nextcloud -D nextcloud -h 10.105.1.12 -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 17
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
MariaDB [nextcloud]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| nextcloud          |
+--------------------+
2 rows in set (0.001 sec)

MariaDB [nextcloud]> USE nextcloud
Database changed
MariaDB [nextcloud]> SHOW TABLES;
Empty set (0.001 sec)

```

### 🌞 Trouver une commande SQL qui permet de lister tous les utilisateurs de la base de données 🌞

```
MariaDB [(none)]> select user from mysql.user;
+-------------+
| User        |
+-------------+
| nextcloud   |
| mariadb.sys |
| mysql       |
| root        |
+-------------+
4 rows in set (0.001 sec)
```

## 2. Serveur Web et NextCloud

```
[john@web ~]$ sudo nano /etc/httpd/conf/httpd.conf
[john@web ~]$ sudo systemctl restart httpd
[john@web ~]$ sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
success
[john@web ~]$  sudo firewall-cmd --reload
success
```

###  🌞 Install de PHP 🌞

```
[john@web ~]$ sudo dnf config-manager --set-enabled crb
[john@web ~]$ sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
[...]
Complete!
[john@web ~]$ dnf module list php
[john@web ~]$  sudo dnf module enable php:remi-8.1 -y
[john@web ~]$ sudo dnf install -y php81-php
```

###  🌞 Install de tous les modules PHP nécessaires pour NextCloud 🌞

```
[john@web ~]$ sudo dnf install -y libxml2 openssl php81-php php81-php-ctype php81-php-curl php81-php-gd php81-php-iconv php81-php-json php81-php-libxml php81-php-mbstring php81-php-openssl php81-php-posix php81-php-session php81-php-xml php81-php-zip php81-php-zlib php81-php-pdo php81-php-mysqlnd php81-php-intl php81-php-bcmath php81-php-gmp
[...]
Complete!
```

###  🌞 Récupérer NextCloud 🌞

```
[john@web ~]$ cd /var/www/
[john@web www]$ sudo mkdir tp5_nextcloud
[john@web ~]$ curl -SLO https://download.nextcloud.com/server/prereleases/nextcloud-25.0.0rc3.zip
[john@web ~]$ unzip nextcloud-25.0.0rc3.zip
[john@web tp5_nextcloud]$ sudo mv nextcloud/* /var/www/tp5_nextcloud/
[john@web tp5_nextcloud]$ ls -al | grep index.html
-rw-r--r--.  1 john john   156 Oct  6 14:42 index.html
[john@web ~]$ sudo chown -R apache:apache /var/www/tp5_nextcloud/
[john@web www]$ ls -al | grep tp5_nextcloud
drwxr-xr-x. 14 apache apache 4096 Jan  9 12:03 tp5_nextcloud
```

### 🌞 Adapter la configuration d'Apache 🌞

```
[john@web ~]$ sudo cat /etc/httpd/conf/httpd.conf | tail -1
IncludeOptional conf.d/*.conf
[john@web conf.d]$ sudo touch website.conf
[john@web conf.d]$ sudo cat website.conf
<VirtualHost *:80>
  # on indique le chemin de notre webroot
  DocumentRoot /var/www/tp5_nextcloud/
  # on précise le nom que saisissent les clients pour accéder au service
  ServerName  web.tp5.linux

  # on définit des règles d'accès sur notre webroot
  <Directory /var/www/tp5_nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews
    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
```

### 🌞 Redémarrer le service Apache 🌞

```
[john@web conf.d]$ sudo systemctl restart httpd
[john@web conf.d]$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; ve>
    Drop-In: /usr/lib/systemd/system/httpd.service.d
             └─php81-php-fpm.conf
     Active: active (running) since Mon 2023-01-09 12:22:09 CET; 54s ago
```

## 3. Finaliser l'installation de NextCloud

```
[john@web ~]$ mysql -u nextcloud -D nextcloud -h 10.105.1.12 -p
Enter password:
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 22
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [nextcloud]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| nextcloud          |
+--------------------+
2 rows in set (0.001 sec)

MariaDB [nextcloud]> use nextcloud;
Database changed
MariaDB [nextcloud]> show tables;
+-----------------------------+
| Tables_in_nextcloud         |
+-----------------------------+
| oc_accounts                 |
| oc_accounts_data            |
| oc_activity                 |
| oc_activity_mq              |
| oc_addressbookchanges       |
| oc_addressbooks             |
| oc_appconfig                |
| oc_authorized_groups        |
| oc_authtoken                |
| oc_bruteforce_attempts      |
| oc_calendar_invitations     |
| oc_calendar_reminders       |
| oc_calendar_resources       |
| oc_calendar_resources_md    |
| oc_calendar_rooms           |
| oc_calendar_rooms_md        |
| oc_calendarchanges          |
| oc_calendarobjects          |
| oc_calendarobjects_props    |
| oc_calendars                |
| oc_calendarsubscriptions    |
| oc_cards                    |
| oc_cards_properties         |
| oc_circles_circle           |
| oc_circles_event            |
| oc_circles_member           |
| oc_circles_membership       |
| oc_circles_mount            |
| oc_circles_mountpoint       |
| oc_circles_remote           |
| oc_circles_share_lock       |
| oc_circles_token            |
| oc_collres_accesscache      |
| oc_collres_collections      |
| oc_collres_resources        |
| oc_comments                 |
| oc_comments_read_markers    |
| oc_dav_cal_proxy            |
| oc_dav_shares               |
| oc_direct_edit              |
| oc_directlink               |
| oc_federated_reshares       |
| oc_file_locks               |
| oc_file_metadata            |
| oc_filecache                |
| oc_filecache_extended       |
| oc_files_trash              |
| oc_flow_checks              |
| oc_flow_operations          |
| oc_flow_operations_scope    |
| oc_group_admin              |
| oc_group_user               |
| oc_groups                   |
| oc_jobs                     |
| oc_known_users              |
| oc_login_flow_v2            |
| oc_migrations               |
| oc_mimetypes                |
| oc_mounts                   |
| oc_notifications            |
| oc_notifications_pushhash   |
| oc_notifications_settings   |
| oc_oauth2_access_tokens     |
| oc_oauth2_clients           |
| oc_photos_albums            |
| oc_photos_albums_files      |
| oc_photos_collaborators     |
| oc_preferences              |
| oc_privacy_admins           |
| oc_profile_config           |
| oc_properties               |
| oc_ratelimit_entries        |
| oc_reactions                |
| oc_recent_contact           |
| oc_schedulingobjects        |
| oc_share                    |
| oc_share_external           |
| oc_storages                 |
| oc_storages_credentials     |
| oc_systemtag                |
| oc_systemtag_group          |
| oc_systemtag_object_mapping |
| oc_text_documents           |
| oc_text_sessions            |
| oc_text_steps               |
| oc_trusted_servers          |
| oc_twofactor_backupcodes    |
| oc_twofactor_providers      |
| oc_user_status              |
| oc_user_transfer_owner      |
| oc_users                    |
| oc_vcategory                |
| oc_vcategory_to_object      |
| oc_webauthn                 |
| oc_whats_new                |
+-----------------------------+
95 rows in set (0.001 sec)
```