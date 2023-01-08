# TP 3 : We do a little scripting

## 0. Un premier script
```
[john@localhost ~]$ mkdir srv
[john@localhost ~]$ cd srv/
[john@localhost srv]$ touch test.sh
[john@localhost srv]$ sudo nano test.sh
[john@localhost srv]$ sudo cat test.sh


#!/bin/bash
# Simple test script

echo "Connecté actuellement avec l'utilisateur $(whoami)."


[john@localhost srv]$ chown john test.sh
[john@localhost srv]$ ls -l
total 4
-rw-r--r--. 1 john john 94 Jan  3 11:36 test.sh
[john@localhost srv]$ sudo chmod 744 test.sh
[john@localhost srv]$ ls -l
total 4
-rwxr--r--. 1 john john 94 Jan  3 10:11 test.sh
[john@localhost ~]$ ./srv/test.sh
Connecté actuellement avec l'utilisateur john.
[john@localhost ~]$ cd srv/
[john@localhost srv]$ ./test.sh
Connecté actuellement avec l'utilisateur john.
```

## I. Script carte d'identité

```
[john@localhost idcard]$ ./idcard.sh
Machine name :  localhost
OS Rocky Linux 9.0 (Blue Onyx) and kernel version is 5.14.0-70.30.1.el9_0.x86_64
IP : 10.16.1.5/24
RAM :629Mi memory available on 1.3Gi total memory
Disk : 1.2G space left
Top 5 processes by RAM usage :
 4.0 /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
 2.1 /usr/sbin/NetworkManager --no-daemon
 1.5 /usr/lib/systemd/systemd --switched-root --system --deserialize 30
 1.3 /usr/lib/systemd/systemd --user
 1.2 /usr/lib/systemd/systemd-logind
Listening ports :
 - 22 tcp : sshd
Here is your random cat : ./super_cat.jpg
```
```
PS C:\Users\lucas> scp john@10.4.1.5:/home/john/srv/idcard/idcard.sh ./
john@10.16.1.5's password:
idcard.sh
```

[Le fichier idcard](idcard.sh)


## II. Script youtube-dl
```
[john@localhost yt]$ bash yt.sh https://www.youtube.com/watch?v=hNXD7XWWo4o
Video https://www.youtube.com/watch?v=hNXD7XWWo4o was downloaded.
File path :/home/john/srv/yt/downloads/YAAAAA meme
```
[le fichier script](yt.sh)

[le fichier log](download.log)


## III. MAKE IT A SERVICE

```
[john@localhost system]$ systemctl status yt
● yt.service - Youtube downloader
     Loaded: loaded (/etc/systemd/system/yt.service; enabled; vendor preset: disabled)
     Active: active (running) since Fri 2021-11-19 11:11:16 CET; 2min 43s ago
   Main PID: 407 (sudo)
      Tasks: 3 (limit: 18800)
     Memory: 21.5M
        CPU: 5.528s
     CGroup: /system.slice/yt.service
             ├─ 407 sudo bash /home/john/srv/yt/yt-v2.sh
             ├─ 648 bash /home/john/srv/yt/yt-v2.sh
             └─2092 sleep 5

Dec 18 11:11:16 localhost systemd[1]: Started Youtube downloader.
Dec 18 11:11:17 localhost sudo[407]:     root : PWD=/ ; USER=root ; COMMAND=/usr/bin/bash /home/john/srv/yt/yt-v2.sh
Dec 18 11:11:17 localhost sudo[407]: pam_unix(sudo:session): session opened for user root(uid=0) by (uid=0)
Dec 18 11:13:49 localhost sudo[648]: Video https://www.youtube.com/watch?v=Wch3gJG2GJ4 was downloaded.
Dec 18 11:13:49 localhost sudo[648]: File path : /home/john/srv/yt/downloads/1 Second Video/1 Second Video.mp4
[john@localhost system]$ journalctl -xe -u yt
[...]
-- Boot 50037b85a2574849b16c71ff5aaf37ed --
Dec 18 11:11:16 localhost systemd[1]: Started Youtube downloader.
░░ Subject: A start job for unit yt.service has finished successfully
░░ Defined-By: systemd
░░ Support: https://forum.manjaro.org/c/support
░░ 
░░ A start job for unit yt.service has finished successfully.
░░ 
░░ The job identifier is 113.
Dec 18 11:11:17 localhost sudo[407]:     root : PWD=/ ; USER=root ; COMMAND=/usr/bin/bash /home/john/srv/yt/yt-v2.sh
Dec 18 11:11:17 localhost sudo[407]: pam_unix(sudo:session): session opened for user root(uid=0) by (uid=0)
Dec 18 11:12:49 localhost sudo[648]: Video https://www.youtube.com/watch?v=Wch3gJG2GJ4 was downloaded.
Dec 18 11:12:49 localhost sudo[648]: File path : /home/john/srv/yt/downloads/1 Second Video/1 Second Video.mp4
```

[le fichier script](yt-v2.sh)
[le fichier service](yt.service)