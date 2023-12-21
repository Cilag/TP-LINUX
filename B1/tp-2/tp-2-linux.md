# Appréhender l'environnement Linux
## I. Service SSH
### 1. Analyse du service
#### S'assurer que le service sshd est démarré
```

[john@vmlinux ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; ven>
     Active: active (running) since Tue 2022-12-06 10:30:28 CET; 13min >
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 714 (sshd)
      Tasks: 1 (limit: 5904)
     Memory: 5.6M
        CPU: 107ms
     CGroup: /system.slice/sshd.service
             └─714 "sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 star>

Dec 06 10:30:28 localhost systemd[1]: Starting OpenSSH server daemon...
Dec 06 10:30:28 localhost sshd[714]: Server listening on 0.0.0.0 port 2>
Dec 06 10:30:28 localhost sshd[714]: Server listening on :: port 22.
Dec 06 10:30:28 localhost systemd[1]: Started OpenSSH server daemon.
Dec 06 10:31:15 localhost.localdomain sshd[829]: Accepted password for >
Dec 06 10:31:15 localhost.localdomain sshd[829]: pam_unix(sshd:session)>
Dec 06 10:34:09 vmlinux sshd[864]: Accepted password for john from>
Dec 06 10:34:09 vmlinux sshd[864]: pam_unix(sshd:session): session open>
```

#### Analyser les processus liés au service SSH

```
[john@vmlinux ~]$ ps -ef | grep sshd
root         714       1  0 10:30 ?        00:00:00 sshd: /usr/sbin/ssh
 -D [listener] 0 of 10-100 startups
root      864     714  0 10:34 ?        00:00:00 sshd: john [priv]
john+     868     864  0 10:34 ?        00:00:00 sshd: john@pts/0
john+     909     869  0 10:46 pts/0    00:00:00 grep --color=auto sshd
```

####  Déterminer le port sur lequel écoute le service SSH

```
[john@vmlinux ~]$ sudo ss -alnpt | grep ssh
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=714,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=714,fd=4))
```

#### Consulter les logs du service SSH

```
[john@vmlinux log]$ sudo tail -n 10 secure
Dec  6 10:50:44 localhost sudo[912]: pam_unix(sudo:session): session closed for user root
Dec  6 10:51:13 localhost sudo[918]: john : TTY=pts/0 ; PWD=/home/john ; USER=root ; COMMAND=/sbin/ss
Dec  6 10:51:14 localhost sudo[918]: pam_unix(sudo:session): session opened for user root(uid=0) by john(uid=1000)
Dec  6 10:51:14 localhost sudo[918]: pam_unix(sudo:session): session closed for user root
Dec  6 10:51:50 localhost sudo[922]: john : TTY=pts/0 ; PWD=/home/john ; USER=root ; COMMAND=/sbin/ss -alnpt
Dec  6 10:51:50 localhost sudo[922]: pam_unix(sudo:session): session opened for user root(uid=0) by john(uid=1000)
Dec  6 10:51:50 localhost sudo[922]: pam_unix(sudo:session): session closed for user root
Dec  6 11:03:02 localhost sudo[965]: john : TTY=pts/0 ; PWD=/var/log ; USER=root ; COMMAND=/bin/cd sssd/
Dec  6 11:03:02 localhost sudo[965]: pam_unix(sudo:session): session opened for user root(uid=0) by john(uid=1000)
Dec  6 11:03:02 localhost sudo[965]: pam_unix(sudo:session): session closed for user root
```

### 2. Modification du service

####  Identifier le fichier de configuration du serveur SSH

```
[john@vmlinux /]$ cd /etc/ssh/
[john@vmlinux ssh]$ ls
moduli        sshd_config.d           ssh_host_ed25519_key.pub
ssh_config    ssh_host_ecdsa_key      ssh_host_rsa_key
ssh_config.d  ssh_host_ecdsa_key.pub  ssh_host_rsa_key.pub
sshd_config   ssh_host_ed25519_key
```
C'est le fichier "sshd_config"

####  Modifier le fichier de conf
```
[john@vmlinux ssh]$ echo $RANDOM
23916

[john@vmlinux ssh]$ sudo nano sshd_config
[john@vmlinux ssh]$ sudo cat sshd_config | grep 23916
   Port 23916
[john@vmlinux ssh]$ sudo firewall-cmd --add-port=23916/tcp --perman
ent
success
[john@vmlinux ssh]$ sudo firewall-cmd --remove-port=22/tcp --perman
ent
Warning: NOT_ENABLED: 22:tcp
success
[john@vmlinux ssh]$ sudo firewall-cmd --reload
success
[john@vmlinux ssh]$ sudo firewall-cmd --list-all | grep 23916
  ports: 23916/tcp
```

#### Redémarrer le service 

```
[john@vmlinux ssh]$ sudo systemctl restart sshd
```

####  Effectuer une connexion SSH sur le nouveau port

```
PS C:\Users\lucas> ssh john@10.4.1.4 -p 23916
john@10.4.1.4's password:
Last login: Tue Dec  6 11:36:18 2022 from 10.4.1.1
```

## II. Service HTTP

### 1. Mise en place

#### Installer le serveur NGINX

```
[john@vmlinux /]$ sudo dnf upgrade
[john@vmlinux /]$ sudo dnf install nginx
```
#### Démarrer le service NGINX

```
[john@vmlinux /]$ sudo systemctl enable --now nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[john@vmlinux /]$ nginx -v
nginx version: nginx/1.20.1
```

#### Déterminer sur quel port tourne NGINX

```
[john@vmlinux /]$ sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
success
[john@vmlinux /]$ sudo firewall-cmd --permanent --zone=public --add-service=https
success
[john@vmlinux /]$ sudo firewall-cmd --reload
success
```
####  Déterminer les processus liés à l'exécution de NGINX

```
[john@vmlinux /]$ ps -ef |grep nginx
root       44066       1  0 12:02 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx      44067   44066  0 12:02 ?        00:00:00 nginx: worker process
nginx      44068   44066  0 12:02 ?        00:00:00 nginx: worker process
john+   44127    1342  0 12:12 pts/0    00:00:00 grep --color=auto nginx
```

#### Euh wait


```
lucas@LAPTOP-GEJ2DKFJ MINGW64 ~
$ curl http://10.4.1.4:80 | head
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0  6783k      0 --:--:-- --:--:-- --:--:-- 7441k<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {


```

### 2. Analyser la conf de NGINX

####  Déterminer le path du fichier de configuration de NGINX

```
[john@vmlinux /]$ ls -al /etc/nginx/nginx.conf
-rw-r--r--. 1 root root 2334 Oct 31 16:37 /etc/nginx/nginx.conf
```

####  Trouver dans le fichier de conf

```
[john@vmlinux nginx]$ sudo cat nginx.conf | grep server -A 14
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }

[john@vmlinux nginx]$ sudo cat nginx.conf | grep 
    include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/default.d/*.conf;
#        include /etc/nginx/default.d/*.conf;
```
### 3. Déployer un nouveau site web

#### Créer un site web
```
[john@vmlinux /]$ cd /var/
[john@vmlinux var]$ sudo mkdir www
[john@vmlinux var]$ ls
adm    db     games     local  mail  preserve  tmp
cache  empty  kerberos  lock   nis   run       www
crash  ftp    lib       log    opt   spool     yp
[john@vmlinux var]$ cd www
[john@vmlinux www]$ sudo mkdir tp2_linux
[john@vmlinux www]$ cd tp2_linux/
[john@vmlinux tp2_linux]$ sudo touch idnex.html
[john@vmlinux tp2_linux]$ sudo nano idnex.html
[john@vmlinux tp2_linux]$ sudo cat idnex.html
<h1>MEOW mon premier serveur web</h1>
```

#### Adapter la conf NGINX

```
[john@vmlinux /]$ cd /etc/nginx/
[john@vmlinux nginx]$ sudo nano nginx.conf
[john@vmlinux nginx]$ sudo systemctl restart nginx
[john@vmlinux nginx]$
[john@vmlinux nginx]$ cd conf.d
[john@vmlinux conf.d]$ sudo touch site_web.conf
[john@vmlinux conf.d]$ ls
site_web.conf
[john@vmlinux conf.d]$ echo $RANDOM
15797
[john@vmlinux conf.d]$ sudo nano site_web.conf
[john@vmlinux conf.d]$ sudo cat site_web.conf
server {
  # le port choisi devra être obtenu avec un 'echo $RANDOM' là encore
  listen 15797;

  root /var/www/tp2_linux;
}
[john@vmlinux conf.d]$ sudo systemctl restart nginx
[john@vmlinux conf.d]$ sudo firewall-cmd --add-port=15797/tcp --per
manent
success
[john@vmlinux conf.d]$ sudo firewall-cmd --reload
success
```

#### Visitez votre super site web

```lucas@LAPTOP-GEJ2DKFJ MINGW64 ~
$ curl http://10.4.1.4:15797 | head
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   153  100   153    0     0   127k      0 --:--:-- --:--:-- --:--:--  149k<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.20.1</center>
</body>
</html>


```

## III. Your own services

### 2. Analyse des services existants

####   Afficher le fichier de service SSH

```
[john@vmlinux ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service;
[john@vmlinux ~]$ cat /usr/lib/systemd/system/sshd.service | grep  ExecStart=
ExecStart=/usr/sbin/sshd -D $OPTIONS
[john@vmlinux ~]$ sudo systemctl start sshd
```

####  Afficher le fichier de service NGINX

```
[john@vmlinux ~]$ systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service;
[john@vmlinux ~]$ cat /usr/lib/systemd/system/nginx.service | grep
 ExecStart=
ExecStart=/usr/sbin/nginx
[john@vmlinux ~]$ sudo sudo systemctl start nginx
```
### 3. Création de service

#### Créez le fichier /etc/systemd/system/tp2_nc.service

```
[john@vmlinux ~]$ cd /etc/systemd/system/
[john@vmlinux system]$sudo touch tp2_nc.service
[john@vmlinux system]$ sudo nano tp2_nc.service
[john@vmlinux system]$ echo $RANDOM
8543
[john@vmlinux system]$ sudo cat  tp2_nc.service
[Unit]
Description=Super netcat tout fou

[Service]
ExecStart=/usr/bin/nc -l 8543µ
[john@vmlinux system]$ sudo firewall-cmd --add-port=8543/tcp --permanent
success
[john@vmlinux system]$ sudo firewall-cmd --reload
success

```
####  Indiquer au système qu'on a modifié les fichiers de service

```
[john@vmlinux system]$  sudo systemctl daemon-reload
```

#### Démarrer notre service de ouf

```
[john@vmlinux system]$ sudo systemctl start tp2_nc.service
```

#### Vérifier que ça fonctionne

```
[john@vmlinux system]$ systemctl status tp2_nc.service
● tp2_nc.service - Super netcat tout fou
     Loaded: loaded (/etc/systemd/system/tp2_nc.service; static)
     Active: active (running) since Thu 2022-12-08 15:30:58 CET; 1min 4>
   Main PID: 44709 (nc)
      Tasks: 1 (limit: 5904)
     Memory: 788.0K
        CPU: 7ms
     CGroup: /system.slice/tp2_nc.service
             └─44709 /usr/bin/nc -l 8888

Dec 08 15:30:58 vmlinux systemd[1]: Started Super netcat tout fou.
```
sur ma VM 
```
[john@vmlinux system]$ nc -l 8543
coucou
fdhgsjcxbvchs
egsxbsbwx
^C
```
sur mon PC
```
C:\Users\lucas\netcat-1.11>nc 10.4.1.4 8543
coucou
fdhgsjcxbvchs
egsxbsbwx

```

####  Les logs de votre service

```
[john@vmlinux system]$ sudo journalctl -xe -u tp2_nc -f
Dec 08 15:30:58 vmlinux systemd[1]: Started Super netcat tout fou.
░░ Subject: A start job for unit tp2_nc.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://access.redhat.com/support
░░
░░ A start job for unit tp2_nc.service has finished successfully.
░░
░░ The job identifier is 7186.
^C

```

#### Affiner la définition du service
```
[john@vmlinux system]$ sudo nano tp2_nc.service
[john@vmlinux system]$ sudo cat tp2_nc.service
[Unit]
Description=Super netcat tout fou

[Service]
ExecStart=/usr/bin/nc -l 8543
Restart=always
[john@vmlinux system]$ sudo systemctl daemon-reload

sur ma VM après quelques minutes d'attentes 
[john@vmlinux system]$ nc -l 8543
qxhc
sde
zd

sur mon pc après quelques minutes d'attentes 
C:\Users\lucas\netcat-1.11>nc 10.4.1.4 8543
qxhc
sde
zd

^C
```