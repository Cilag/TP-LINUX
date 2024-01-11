# TP1 : Premiers pas Docker

# I. Init
🌞 Ajouter votre utilisateur au groupe docker

```
[c1@localhost ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
🌞 Lancer un conteneur NGINX

```
[c1@localhost ~]$ docker run -d -p 9999:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
af107e978371: Pull complete
336ba1f05c3e: Pull complete
8c37d2ff6efa: Pull complete
51d6357098de: Pull complete
782f1ecce57d: Pull complete
5e99d351b073: Pull complete
7b73345df136: Pull complete
Digest: sha256:bd30b8d47b230de52431cc71c5cce149b8d5d4c87c204902acf2504435d4b4c9
Status: Downloaded newer image for nginx:latest
8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00
```

🌞 Visitons

```
[c1@localhost ~]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                   NAMES
8b075ae4d344   nginx     "/docker-entrypoint.…"   16 minutes ago   Up 16 minutes   0.0.0.0:9999->80/tcp, :::9999->80/tcp   epic_davinci
```
```
[c1@localhost ~]$ docker logs 8b075ae4d344
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/12/21 14:39:33 [notice] 1#1: using the "epoll" event method
2023/12/21 14:39:33 [notice] 1#1: nginx/1.25.3
2023/12/21 14:39:33 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
2023/12/21 14:39:33 [notice] 1#1: OS: Linux 4.18.0-477.27.1.el8_8.x86_64
2023/12/21 14:39:33 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2023/12/21 14:39:33 [notice] 1#1: start worker processes
2023/12/21 14:39:33 [notice] 1#1: start worker process 28
2023/12/21 14:39:33 [notice] 1#1: start worker process 29
```
```
[c1@localhost ~]$ docker inspect 8b075ae4d344
[
    {
        "Id": "8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00",
        "Created": "2023-12-21T14:39:32.788816837Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 14006,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-12-21T14:39:33.794057411Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:d453dd892d9357f3559b967478ae9cbc417b52de66b53142f6c16c8a275486b9",
        "ResolvConfPath": "/var/lib/docker/containers/8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00/hostname",
        "HostsPath": "/var/lib/docker/containers/8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00/hosts",
        "LogPath": "/var/lib/docker/containers/8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00/8b075ae4d3445b7d15d28ec5dab491b7e5e086551511c39a56ede5dba785cd00-json.log",
        "Name": "/epic_davinci",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "80/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "9999"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                32,
                133
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "host",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/5883f6b40574d193b2e13c9f5900a9dab7e1739e5550e13d187dd8d6aea59c3d-init/diff:/var/lib/docker/overlay2/1a909c774df779dac711c4665aaa652f6cd74bfc2288af1f60aa08c1db97a5d5/diff:/var/lib/docker/overlay2/d13bc08ca895eed1ca24e6cd4554bb35e2467c58e62efb24b71ed89a1fc8455d/diff:/var/lib/docker/overlay2/2095ff9dee4225a0ca9b378593aa36060846b328ca1d436bb34b365368221f92/diff:/var/lib/docker/overlay2/bfbcfcd752db7c1d291bbad48c9aee3ee4653d95e1a1cf5a67bb1df4c6ae4e9b/diff:/var/lib/docker/overlay2/7ac30c5873c1ff055d802d916003b2dd1b907df98c5087e019564308ffa59c9e/diff:/var/lib/docker/overlay2/0a3978ff6f75c804bd0f19ab5429b7cec838125fa708671aa93e7cd9b1e04bf1/diff:/var/lib/docker/overlay2/406fcfa512e7689d34cbe367acfef52f69d88a4fe40cb2e4b7c6c866e541dd63/diff",
                "MergedDir": "/var/lib/docker/overlay2/5883f6b40574d193b2e13c9f5900a9dab7e1739e5550e13d187dd8d6aea59c3d/merged",
                "UpperDir": "/var/lib/docker/overlay2/5883f6b40574d193b2e13c9f5900a9dab7e1739e5550e13d187dd8d6aea59c3d/diff",
                "WorkDir": "/var/lib/docker/overlay2/5883f6b40574d193b2e13c9f5900a9dab7e1739e5550e13d187dd8d6aea59c3d/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "8b075ae4d344",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NGINX_VERSION=1.25.3",
                "NJS_VERSION=0.8.2",
                "PKG_RELEASE=1~bookworm"
            ],
            "Cmd": [
                "nginx",
                "-g",
                "daemon off;"
            ],
            "Image": "nginx",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": [
                "/docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {
                "maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
            },
            "StopSignal": "SIGQUIT"
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "c8e559ec545e8fe7e3ddd449913b540e37dbd4528d75c16eaac7a9ef1735be43",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "80/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "9999"
                    },
                    {
                        "HostIp": "::",
                        "HostPort": "9999"
                    }
                ]
            },
            "SandboxKey": "/var/run/docker/netns/c8e559ec545e",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "b895a5eb12c40e9efad62b3291e8da500860b07f802d5705adc22bf249d07b37",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "e2cd231bc3de1669afecdc333fd7bee7b12c18d8f3c909798b4886c91f903971",
                    "EndpointID": "b895a5eb12c40e9efad62b3291e8da500860b07f802d5705adc22bf249d07b37",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        }
    }
]
```
```
[c1@localhost ~]$ sudo ss -lnpt
[sudo] password for c1:
State      Recv-Q     Send-Q         Local Address:Port           Peer Address:Port     Process
LISTEN     0          2048                 0.0.0.0:9999                0.0.0.0:*         users:(("docker-proxy",pid=13964,fd=4))
LISTEN     0          128                  0.0.0.0:22                  0.0.0.0:*         users:(("sshd",pid=772,fd=3))
LISTEN     0          2048                    [::]:9999                   [::]:*         users:(("docker-proxy",pid=13969,fd=4))
LISTEN     0          128                     [::]:22                     [::]:*         users:(("sshd",pid=772,fd=4))
```
```
[c1@localhost ~]$ sudo iptables -A INPUT -p tcp --dport 9999 -j ACCEPT
```
![Alt text](<Capture d'écran 2023-12-21 160945.png>)


🌞 On va ajouter un site Web au conteneur NGINX

```
[c1@localhost nginx]$ docker run -d -p 9999:8080 -v /home/c1/nginx/index.html:/var/www/html/index.html -v /home/c1/nginx/site_nul.conf:/etc/nginx/conf.d/site_nul.conf nginx
9c8c32b8d4d4a52c0bfb2575e985bc9281fb873515f9e0b2060133557eebec29
[c1@localhost nginx]$ cat index.html
<h1>coucou le site fonction</h1>
[c1@localhost nginx]$ cat site_nul.conf
server {
    listen        8080;

    location / {
        root /var/www/html;
    }
}
```

🌞 Visitons

```
[c1@localhost nginx]$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS
NAMES
9c8c32b8d4d4   nginx     "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   80/tcp, 0.0.0.0:9999->8080/tcp, :::9999->8080/tcp   upbeat_hypatia
```
![Alt text](<Capture d'écran 2023-12-21 162306.png>)


🌞 Lance un conteneur Python, avec un shell

```
[c1@localhost nginx]$ docker run -it python bash
Unable to find image 'python:latest' locally
latest: Pulling from library/python
bc0734b949dc: Pull complete
b5de22c0f5cd: Pull complete
917ee5330e73: Pull complete
b43bd898d5fb: Pull complete
7fad4bffde24: Pull complete
d685eb68699f: Pull complete
107007f161d0: Pull complete
02b85463d724: Pull complete
Digest: sha256:3733015cdd1bd7d9a0b9fe21a925b608de82131aa4f3d397e465a1fcb545d36f
Status: Downloaded newer image for python:latest
```

🌞 Installe des libs Python

```
root@e4f7db69e161:/# pip install aiohttp
Collecting aiohttp
  Obtaining dependency information for aiohttp from https://files.pythonhosted.org/packages/75/5f/90a2869ad3d1fb9bd984bfc1b02d8b19e381467b238bd3668a09faa69df5/aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (7.4 kB)
Collecting attrs>=17.3.0 (from aiohttp)
  Downloading attrs-23.1.0-py3-none-any.whl (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.2/61.2 kB 1.7 MB/s eta 0:00:00
Collecting multidict<7.0,>=4.5 (from aiohttp)
  Downloading multidict-6.0.4.tar.gz (51 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 51.3/51.3 kB 1.3 MB/s eta 0:00:00
  Installing build dependencies ... done
  Getting requirements to build wheel ... done
  Installing backend dependencies ... done
  Preparing metadata (pyproject.toml) ... done
Collecting yarl<2.0,>=1.0 (from aiohttp)
  Obtaining dependency information for yarl<2.0,>=1.0 from https://files.pythonhosted.org/packages/28/1c/bdb3411467b805737dd2720b85fd082e49f59bf0cc12dc1dfcc80ab3d274/yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (31 kB)
Collecting frozenlist>=1.1.1 (from aiohttp)
  Obtaining dependency information for frozenlist>=1.1.1 from https://files.pythonhosted.org/packages/0b/f2/b8158a0f06faefec33f4dff6345a575c18095a44e52d4f10c678c137d0e0/frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata
  Downloading frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (12 kB)
Collecting aiosignal>=1.1.2 (from aiohttp)
  Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Collecting idna>=2.0 (from yarl<2.0,>=1.0->aiohttp)
  Obtaining dependency information for idna>=2.0 from https://files.pythonhosted.org/packages/c2/e7/a82b05cf63a603df6e68d59ae6a68bf5064484a0718ea5033660af4b54a9/idna-3.6-py3-none-any.whl.metadata
  Downloading idna-3.6-py3-none-any.whl.metadata (9.9 kB)
Downloading aiohttp-3.9.1-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.3 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.3/1.3 MB 3.0 MB/s eta 0:00:00
Downloading frozenlist-1.4.1-cp312-cp312-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (281 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 281.5/281.5 kB 5.8 MB/s eta 0:00:00
Downloading yarl-1.9.4-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (322 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 322.4/322.4 kB 4.6 MB/s eta 0:00:00
Downloading idna-3.6-py3-none-any.whl (61 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.6/61.6 kB 2.4 MB/s eta 0:00:00
Building wheels for collected packages: multidict
  Building wheel for multidict (pyproject.toml) ... done
  Created wheel for multidict: filename=multidict-6.0.4-cp312-cp312-linux_x86_64.whl size=114916 sha256=1dde984a185b3920b587b3fc8ca3172bc3724d1f0ec19e2aace77b47ef5a0b01
  Stored in directory: /root/.cache/pip/wheels/f6/d8/ff/3c14a64b8f2ab1aa94ba2888f5a988be6ab446ec5c8d1a82da
Successfully built multidict
Installing collected packages: multidict, idna, frozenlist, attrs, yarl, aiosignal, aiohttp
Successfully installed aiohttp-3.9.1 aiosignal-1.3.1 attrs-23.1.0 frozenlist-1.4.1 idna-3.6 multidict-6.0.4 yarl-1.9.4
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

[notice] A new release of pip is available: 23.2.1 -> 23.3.2
[notice] To update, run: pip install --upgrade pip
root@e4f7db69e161:/# pip install aioconsole
Collecting aioconsole
  Obtaining dependency information for aioconsole from https://files.pythonhosted.org/packages/f7/39/b392dc1a8bb58342deacc1ed2b00edf88fd357e6fdf76cc6c8046825f84f/aioconsole-0.7.0-py3-none-any.whl.metadata
  Downloading aioconsole-0.7.0-py3-none-any.whl.metadata (5.3 kB)
Downloading aioconsole-0.7.0-py3-none-any.whl (30 kB)
Installing collected packages: aioconsole
Successfully installed aioconsole-0.7.0
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

[notice] A new release of pip is available: 23.2.1 -> 23.3.2
[notice] To update, run: pip install --upgrade pip
root@e4f7db69e161:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import aiohttp
>>>
```
# II. Images

🌞 Récupérez des images
```
[c1@localhost nginx]$ docker pull python
Using default tag: latest
latest: Pulling from library/python
Digest: sha256:3733015cdd1bd7d9a0b9fe21a925b608de82131aa4f3d397e465a1fcb545d36f
Status: Image is up to date for python:latest
docker.io/library/python:latest
[c1@localhost nginx]$ docker pull mysql
Using default tag: latest
latest: Pulling from library/mysql
bce031bc522d: Pull complete
cf7e9f463619: Pull complete
105f403783c7: Pull complete
878e53a613d8: Pull complete
2a362044e79f: Pull complete
6e4df4f73cfe: Pull complete
69263d634755: Pull complete
fe5e85549202: Pull complete
5c02229ce6f1: Pull complete
7320aa32bf42: Pull complete
Digest: sha256:2d82ba6960cdf254de13f57d7265570c0675bc8bae1051e4a9806cff863006c9
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest
[c1@localhost nginx]$ docker pull wordpress
Using default tag: latest
latest: Pulling from library/wordpress
af107e978371: Already exists
6480d4ad61d2: Pull complete
95f5176ece8b: Pull complete
0ebe7ec824ca: Pull complete
673e01769ec9: Pull complete
74f0c50b3097: Pull complete
1a19a72eb529: Pull complete
50436df89cfb: Pull complete
8b616b90f7e6: Pull complete
df9d2e4043f8: Pull complete
d6236f3e94a1: Pull complete
59fa8b76a6b3: Pull complete
99eb3419cf60: Pull complete
22f5c20b545d: Pull complete
1f0d2c1603d0: Pull complete
4624824acfea: Pull complete
79c3af11cab5: Pull complete
e8d8239610fb: Pull complete
a1ff013e1d94: Pull complete
31076364071c: Pull complete
87728bbad961: Pull complete
Digest: sha256:be7173998a8fa131b132cbf69d3ea0239ff62be006f1ec11895758cf7b1acd9e
Status: Downloaded newer image for wordpress:latest
docker.io/library/wordpress:latest
[c1@localhost nginx]$ docker pull linuxserver/wikijs
Using default tag: latest
latest: Pulling from linuxserver/wikijs
8b16ab80b9bd: Pull complete
07a0e16f7be1: Pull complete
145cda5894de: Pull complete
1a16fa4f6192: Pull complete
84d558be1106: Pull complete
4573be43bb06: Pull complete
20b23561c7ea: Pull complete
Digest: sha256:131d247ab257cc3de56232b75917d6f4e24e07c461c9481b0e7072ae8eba3071
Status: Downloaded newer image for linuxserver/wikijs:latest
docker.io/linuxserver/wikijs:latest
[c1@localhost nginx]$ docker image ls
REPOSITORY           TAG       IMAGE ID       CREATED       SIZE
mysql                latest    73246731c4b0   2 days ago    619MB
linuxserver/wikijs   latest    869729f6d3c5   6 days ago    441MB
python               latest    fc7a60e86bae   13 days ago   1.02GB
wordpress            latest    fd2f5a0c6fba   2 weeks ago   739MB
nginx                latest    d453dd892d93   8 weeks ago   187MB
```


🌞 Lancez un conteneur à partir de l'image Python
```
[c1@localhost nginx]$ docker run -it python bash
root@bdc349d0ae41:/# python
Python 3.12.1 (main, Dec 19 2023, 20:14:15) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
```


🌞 Ecrire un Dockerfile pour une image qui héberge une application Python
```
[c1@localhost python_app_build]$ docker build . -t python_app:version_de_ouf
[+] Building 1.0s (12/12) FINISHED                                                                                    docker:default
 => [internal] load build definition from Dockerfile                                                                            0.0s
 => => transferring dockerfile: 283B                                                                                            0.0s
 => [internal] load .dockerignore                                                                                               0.0s
 => => transferring context: 2B                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                0.8s
 => [1/7] FROM docker.io/library/ubuntu:latest@sha256:6042500cf4b44023ea1894effe7890666b0c5c7871ed83a97c36c76ae560bb9b          0.0s
 => [internal] load build context                                                                                               0.0s
 => => transferring context: 367B                                                                                               0.0s
 => CACHED [2/7] RUN apt-get update -y                                                                                          0.0s
 => CACHED [3/7] RUN apt-get install -y python3                                                                                 0.0s
 => CACHED [4/7] RUN apt-get install pip -y                                                                                     0.0s
 => CACHED [5/7] RUN pip install emoji                                                                                          0.0s
 => CACHED [6/7] WORKDIR /app                                                                                                   0.0s
 => [7/7] COPY . /app                                                                                                           0.1s
 => exporting to image                                                                                                          0.1s
 => => exporting layers                                                                                                         0.0s
 => => writing image sha256:827683d1052f28b0e01c50af898803c8ea6e1c035526e2c8cd80e5a0e6462e6d                                    0.0s
 => => naming to docker.io/library/python_app:version_de_ouf                                                                    0.0s
 ```
 
 ```
[c1@localhost python_app_build]$ docker run python_app:version_de_ouf
Cet exemple d'application est vraiment naze 👎
[c1@localhost python_app_build]$
```
# III. Docker compose

🌞 Créez un fichier docker-compose.yml


```
[c1@localhost compose_test]$ cat docker-compose.yml
version: "3"

services:
  conteneur_nul:
    image: debian
    entrypoint: sleep 9999
  conteneur_floresque:
    image: debian
    entrypoint: sleep 9999
```

🌞 Lancez les deux conteneurs avec docker compose

```
[c1@localhost compose_test]$ docker compose up -d
[+] Running 3/3
 ✔ conteneur_floresque 1 layers [⣿]      0B/0B      Pulled                                                                     19.3s
   ✔ 1b13d4e1a46e Pull complete                                                                                                13.4s
 ✔ conteneur_nul Pulled                                                                                                        19.3s
[+] Running 3/3
 ✔ Network compose_test_default                  Created                                                                        0.4s
 ✔ Container compose_test-conteneur_floresque-1  Started                                                                        0.4s
 ✔ Container compose_test-conteneur_nul-1        Started                                                                        0.4s
```

🌞 Vérifier que les deux conteneurs tournent

```
[c1@localhost compose_test]$ docker compose ps
NAME                                 IMAGE     COMMAND        SERVICE               CREATED          STATUS          PORTS
compose_test-conteneur_floresque-1   debian    "sleep 9999"   conteneur_floresque   52 seconds ago   Up 51 seconds
compose_test-conteneur_nul-1         debian    "sleep 9999"   conteneur_nul         52 seconds ago   Up 51 seconds
[c1@localhost compose_test]$
```

🌞 Pop un shell dans le conteneur conteneur_nul
```
root@0470caf512b1:/# apt-get update

root@0470caf512b1:/# apt-get install -y iputils-ping
```
```
root@0470caf512b1:/# ping conteneur_floresque
PING conteneur_floresque (172.18.0.3) 56(84) bytes of data.
64 bytes from compose_test-conteneur_floresque-1.compose_test_default (172.18.0.3): icmp_seq=1 ttl=64 time=0.225 ms
64 bytes from compose_test-conteneur_floresque-1.compose_test_default (172.18.0.3): icmp_seq=2 ttl=64 time=1.17 ms
64 bytes from compose_test-conteneur_floresque-1.compose_test_default (172.18.0.3): icmp_seq=3 ttl=64 time=0.392 ms
64 bytes from compose_test-conteneur_floresque-1.compose_test_default (172.18.0.3): icmp_seq=4 ttl=64 time=0.676 ms
64 bytes from compose_test-conteneur_floresque-1.compose_test_default (172.18.0.3): icmp_seq=5 ttl=64 time=0.130 ms
^C
--- conteneur_floresque ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4079ms
rtt min/avg/max/mdev = 0.130/0.519/1.174/0.376 ms
root@0470caf512b1:/#
```