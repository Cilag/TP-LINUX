# TP4 : Vers une maîtrise des OS Linux
# I. Partitionnement
## 1. LVM dès l'installation

🌞 **Faites une install manuelle de Rocky Linux**
```
[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    2G  0 part /boot
└─sda2        8:2    0   21G  0 part
  ├─rl-root 253:0    0   10G  0 lvm  /
  ├─rl-swap 253:1    0    1G  0 lvm  [SWAP]
  ├─rl-home 253:2    0    5G  0 lvm  /home
  └─rl-var  253:3    0    5G  0 lvm  /var
sr0          11:0    1 1024M  0 rom
[root@localhost ~]# df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             870M     0  870M   0% /dev
tmpfs                890M     0  890M   0% /dev/shm
tmpfs                890M  8.6M  881M   1% /run
tmpfs                890M     0  890M   0% /sys/fs/cgroup
/dev/mapper/rl-root  9.8G  1.9G  7.5G  20% /
/dev/sda1            2.0G  200M  1.8G  10% /boot
/dev/mapper/rl-home  4.9G   44K  4.6G   1% /home
/dev/mapper/rl-var   4.9G  140M  4.5G   3% /var
tmpfs                178M     0  178M   0% /run/user/1000
tmpfs                178M     0  178M   0% /run/user/0
[root@localhost ~]# pvs
  PV         VG Fmt  Attr PSize  PFree
  /dev/sda2  rl lvm2 a--  21.00g 4.00m
[root@localhost ~]# pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               rl
  PV Size               <21.01 GiB / not usable 2.00 MiB
  Allocatable           yes
  PE Size               4.00 MiB
  Total PE              5377
  Free PE               1
  Allocated PE          5376
  PV UUID               TqBcJC-cds6-14EN-bFut-79vt-xm1G-Qascxx

[root@localhost ~]# vgs
  VG #PV #LV #SN Attr   VSize  VFree
  rl   1   4   0 wz--n- 21.00g 4.00m

[root@localhost ~]# vgdisplay
  --- Volume group ---
  VG Name               rl
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  5
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                4
  Open LV               4
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               21.00 GiB
  PE Size               4.00 MiB
  Total PE              5377
  Alloc PE / Size       5376 / 21.00 GiB
  Free  PE / Size       1 / 4.00 MiB
  VG UUID               UAmWde-wtQ3-yMMM-QbRu-7WTp-9TnO-NmfWUW

[root@localhost ~]# lvs
  LV   VG Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  home rl -wi-ao----  5.00g
  root rl -wi-ao---- 10.00g
  swap rl -wi-ao----  1.00g
  var  rl -wi-ao----  5.00g

[root@localhost ~]# lvdisplay
  --- Logical volume ---
  LV Path                /dev/rl/swap
  LV Name                swap
  VG Name                rl
  LV UUID                rCoa6l-D35E-NSzC-CUO4-1vGH-qHh5-2z9w0e
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-18 08:51:21 -0500
  LV Status              available
  # open                 2
  LV Size                1.00 GiB
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/rl/home
  LV Name                home
  VG Name                rl
  LV UUID                Rem0Ke-DuVy-j4Zx-eDYG-s81U-OHDd-ceiH19
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-18 08:51:21 -0500
  LV Status              available
  # open                 1
  LV Size                5.00 GiB
  Current LE             1280
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:2

  --- Logical volume ---
  LV Path                /dev/rl/root
  LV Name                root
  VG Name                rl
  LV UUID                Ub3fse-saqz-PIF5-Jmv0-6s3r-Zusp-K3iTCV
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-18 08:51:22 -0500
  LV Status              available
  # open                 1
  LV Size                10.00 GiB
  Current LE             2560
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0

  --- Logical volume ---
  LV Path                /dev/rl/var
  LV Name                var
  VG Name                rl
  LV UUID                USx1jG-Pcg9-x8Ee-ujsV-7oO0-Bzck-0xnhbk
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2024-01-18 08:51:22 -0500
  LV Status              available
  # open                 1
  LV Size                5.00 GiB
  Current LE             1280
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:3
```
## 2. Scénario remplissage de partition

🌞 **Remplissez votre partition `/home`**

- on va simuler avec un truc bourrin :

```
[root@localhost home]# dd if=/dev/zero of=/home/c1/bigfile bs=4M count=5000
dd: error writing '/home/c1/bigfile': No space left on device
1235+0 records in
1234+0 records out
5179555840 bytes (5.2 GB, 4.8 GiB) copied, 11.6204 s, 446 MB/s
```

🌞 **Constater que la partition est pleine**

```
[root@localhost ~]# df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             870M     0  870M   0% /dev
tmpfs                890M     0  890M   0% /dev/shm
tmpfs                890M  8.6M  881M   1% /run
tmpfs                890M     0  890M   0% /sys/fs/cgroup
/dev/mapper/rl-root  9.8G  1.9G  7.5G  20% /
/dev/sda1            2.0G  200M  1.8G  10% /boot
/dev/mapper/rl-home  4.9G  4.9G     0 100% /home
/dev/mapper/rl-var   4.9G  140M  4.5G   3% /var
tmpfs                178M     0  178M   0% /run/user/1000
tmpfs                178M     0  178M   0% /run/user/0
```

🌞 **Agrandir la partition**

- avec des commandes LVM il faut agrandir le logical volume
- ensuite il faudra indiquer au système de fichier ext4 que la partition a été agrandie
- prouvez avec un `df -h` que vous avez récupéré de l'espace en plus

🌞 **Remplissez votre partition `/home`**

- on va simuler encore avec un truc bourrin :

```
dd if=/dev/zero of=/home/<TON_USER>/bigfile bs=4M count=5000
```

> 5000x4M ça fait toujours 40G. Et ça fait toujours trop.

➜ **Eteignez la VM et ajoutez lui un disque de 40G**

🌞 **Utiliser ce nouveau disque pour étendre la partition `/home` de 40G**

```
[c1@localhost ~]$ sudo pvcreate -ff /dev/sdb
[sudo] password for c1:
  Physical volume "/dev/sdb" successfully created.
[c1@localhost ~]$ sudo vgextend rl /dev/sdb
  Volume group "rl" successfully extended
[c1@localhost ~]$ sudo lvextend -l +100%FREE /dev/rl/home
  Size of logical volume rl/home changed from 5.00 GiB (1281 extents) to 45.00 GiB (11520 extents).
  Logical volume rl/home successfully resized.
[c1@localhost ~]$ sudo resize2fs /dev/rl/home
resize2fs 1.45.6 (20-Mar-2020)
Filesystem at /dev/rl/home is mounted on /home; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 6
The filesystem on /dev/rl/home is now 11796480 (4k) blocks long.

[c1@localhost ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             870M     0  870M   0% /dev
tmpfs                890M     0  890M   0% /dev/shm
tmpfs                890M  8.5M  881M   1% /run
tmpfs                890M     0  890M   0% /sys/fs/cgroup
/dev/mapper/rl-root  9.8G  1.9G  7.5G  20% /
/dev/sda1            2.0G  200M  1.8G  10% /boot
/dev/mapper/rl-var   4.9G  142M  4.5G   4% /var
/dev/mapper/rl-home   45G  4.9G   38G  12% /home
tmpfs                178M     0  178M   0% /run/user/1000
[c1@localhost ~]$
```
> Si vous avez assez d'espace libre, et que vous voulez montrer la taille de votre kiki, vous pouvez refaire la commande `dd` et vraiment créer le fichier de 40G.

# II. Gestion de users

Je vous l'ai jamais demandé, alors c'est limite un interlude obligé que j'ai épargné à tout le monde, mais les admins, vous y échapperez pas.

On va faire un petit exercice tout nul de gestion d'utilisateurs.

> *Si t'es si fort, ça prend même pas 2-3 min, alors fais-le :D*

🌞 **Gestion basique de users**

- créez des users en respactant le tableau suivant :

| Name    | Groupe primaire | Groupes secondaires | Password | Homedir         | Shell              |
| ------- | --------------- | ------------------- | -------- | --------------- | ------------------ |
| alice   | alice           | admins              | toto     | `/home/alice`   | `/bin/bash`        |
| bob     | bob             | admins              | toto     | `/home/bob`     | `/bin/bash`        |
| charlie | charlie         | admins              | toto     | `/home/charlie` | `/bin/bash`        |
| eve     | eve             | N/A                 | toto     | `/home/eve`     | `/bin/bash`        |
| backup  | backup          | N/A                 | toto     | `/var/backup`   | `/usr/bin/nologin` |

```
[c1@localhost ~]$ cat /etc/passwd
alice:x:1001:1001::/home/alice:/bin/bash
bob:x:1002:1003::/home/bob:/bin/bash
charlie:x:1003:1004::/home/charlie:/bin/bash
eve:x:1004:1005::/home/eve:/bin/bash
backup:x:1005:1006::/var/backup:/usr/bin/nologin
```

🌞 **La conf `sudo` doit être la suivante**
```
[c1@localhost ~]$sudo visudo
%admins ALL=(ALL) NOPASSWD: ALL
eve ALL=(backup) /bin/ls, PASSWD: /bin/ls
```

🌞 **Le dossier `/var/backup`**

```
[c1@localhost var]$ sudo chmod 700 /var/backup
[c1@localhost var]$ sudo chown backup:backup /var/backup
[c1@localhost var]$ sudo touch /var/backup/precious_backup
[c1@localhost var]$ sudo chmod 640 /var/backup/precious_backup
[c1@localhost var]$ sudo chown backup:backup /var/backup/precious_backup
```

🌞 **Mots de passe des users, prouvez que**

```
[c1@localhost var]$ sudo cat /etc/shadow
alice:$6$HwIgqT8gA4iTmEF4$Zfn5PDe9BVia0D0nXyL6K3wCGWOfBsOsKoEofmKPBGmFqHxtscmWkCbiI5Gdq4Uahy5q6xY0zw8.W9EzEXWJC/:19747:0:99999:7:::
bob:$6$fnpq3QUnbBYKmVW6$y8.hTzyrpMCKCZh2o82U8ynFOAv/KS6H.8gzI3jDnvMuRGjZ0dniVLmA7BprJpTFN.L9kpFyH87UlAzSMPBHa.:19747:0:99999:7:::
charlie:$6$HHVwlNSrpyIjxyHF$l5vNGCg1A3wjScJf/TRwL3dfgg2bGMq5K54BPC9eU/7b2RREcktHD/6FTzp48.foOyJPNIOEN4S2tl4zNiOb1/:19747:0:99999:7:::
eve:$6$oPBezZ3QovOcHXCj$bDBDgZUQk0gn94FDtywXdD1Dry7m7VB0F6mMcLKA2aCa.8GR5180I53OgRKiO2PhMRHxyw0AZCrN6wEuWd4uw.:19747:0:99999:7:::
backup:!!:19747:0:99999:7:::
```
🌞 **User eve**

```
[eve@localhost ~]$ sudo -l

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for eve:
Sorry, user eve may not run sudo on localhost.
```

# III. Gestion du temps

![Timing](./img/timing.jpg)

Il y a un service qui tourne en permanence (ou pas) sur les OS modernes pour maintenir l'heure de la machine synchronisée avec l'heure que met à disposition des serveurs.

Le protocole qui sert à faire ça s'appelle NTP (Network Time Protocol, tout simplement). Il existe donc des serveurs NTP. Et le service qui tourne en permanence sur nos PCs/serveurs, c'est donc un client NTP.

Il existe des serveurs NTP publics, hébergés gracieusement, comme le projet [NTP Pool](https://www.ntppool.org).

🌞 **Je vous laisse gérer le bail vous-mêmes**

```
[c1@localhost ~]$ systemctl list-units -t service -a | grep ntp
initrd-parse-etc.service                   loaded    inactive dead    Mountpoints Configured in the Real Root
● ntpd.service                               not-found inactive dead    ntpd.service

● ntpdate.service                            not-found inactive dead    ntpdate.service

● sntp.service                               not-found inactive dead    sntp.service
```
```
[c1@localhost etc]$ sudo cat /etc/chrony.conf
[sudo] password for c1:
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
pool 2.rocky.pool.ntp.org
```
```
[c1@localhost etc]$ timedatectl
               Local time: Thu 2024-01-25 16:26:16 CET
           Universal time: Thu 2024-01-25 15:26:16 UTC
                 RTC time: Thu 2024-01-25 15:26:16
                Time zone: Europe/Paris (CET, +0100)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no
```
