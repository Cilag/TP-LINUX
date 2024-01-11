# TP3 Admin : Vagrant

## Sommaire

- [TP3 Admin : Vagrant](#tp3-admin--vagrant)
  - [Sommaire](#sommaire)
  - [Sommaire](#sommaire-1)
  - [1. Une première VM](#1-une-première-vm)
  - [2. Repackaging](#2-repackaging)
  - [3. Moult VMs](#3-moult-vms)

## 1. Une première VM

🌞 **Générer un `Vagrantfile`**

- vous bosserez avec cet OS pour le restant du TP
- vous pouvez générer une `Vagrantfile` fonctionnel pour une box donnée avec les commandes :

```bash
PS C:\Users\ozoux> mkdir ~/work/vagrant/test


    Répertoire : C:\Users\ozoux\work\vagrant


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        11/01/2024     14:13                test


PS C:\Users\ozoux> cd ~/work/vagrant/test
PS C:\Users\ozoux\work\vagrant\test> vagrant init premiere_box
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
PS C:\Users\ozoux\work\vagrant\test> ls


    Répertoire : C:\Users\ozoux\work\vagrant\test


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        11/01/2024     14:16           3463 Vagrantfile


PS C:\Users\ozoux\work\vagrant\test> cat Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "premiere_box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessable to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
PS C:\Users\ozoux\work\vagrant\test>
```

🌞 **Modifier le `Vagrantfile`**

- les lignes qui suivent doivent être ajouter dans le bloc où l'objet `config` est défini
- ajouter les lignes suivantes :

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/rockylinux8"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]   
  end  
end

```

🌞 **Faire joujou avec une VM**

```bash
PS C:\Users\ozoux\work\vagrant\test> vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'geerlingguy/rockylinux8'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: test_default_1704982417682_69426
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default:
    default: Guest Additions Version: 6.1.32
    default: VirtualBox Version: 7.0
PS C:\Users\ozoux\work\vagrant\test> vagrant status
Current machine states:

default                   running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.
PS C:\Users\ozoux\work\vagrant\test> vagrant ssh
Activate the web console with: systemctl enable --now cockpit.socket

[vagrant@localhost ~]$ exit
logout
Connection to 127.0.0.1 closed.
PS C:\Users\ozoux\work\vagrant\test> vagrant halt
==> default: Attempting graceful shutdown of VM...
PS C:\Users\ozoux\work\vagrant\test> vagrant destroy -f
==> default: Destroying VM and associated drives...
PS C:\Users\ozoux\work\vagrant\test>
```

## 2. Repackaging

🌞 **Repackager la box que vous avez choisie**

- elle doit :
  - être à jour
  - disposer des commandes `vim`, `ip`, `dig`, `ss`, `nc`
  - avoir un firewall actif
  - SELinux (systèmes RedHat) et/ou AppArmor (plutôt sur Ubuntu) désactivés
- pour repackager une box, vous pouvez utiliser les commandes suivantes :

```bash
PS C:\Users\ozoux\work\vagrant\test> vagrant package --output super_box.box
==> default: Attempting graceful shutdown of VM...
==> default: Clearing any previously set forwarded ports...
==> default: Exporting VM...
==> default: Compressing package to: C:/Users/ozoux/work/vagrant/test/super_box.box
PS C:\Users\ozoux\work\vagrant\test> vagrant box add super_box super_box.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'super_box' (v0) for provider:
    box: Unpacking necessary files from: file://C:/Users/ozoux/work/vagrant/test/super_box.box
    box:
==> box: Successfully added box 'super_box' (v0) for ''!
PS C:\Users\ozoux\work\vagrant\test> vagrant box list
geerlingguy/rockylinux8 (virtualbox, 1.0.1)
generic/rocky9          (virtualbox, 4.3.2)
super_box               (virtualbox, 0)
PS C:\Users\ozoux\work\vagrant\test>
```

🌞 **Ecrivez un `Vagrantfile` qui lance une VM à partir de votre Box**

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/rockylinux8"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]  
  end   
  # Configuration des réseaux
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Configuration des ressources de la machine virtuelle
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
  end

  # Provisions supplémentaires (facultatif)
  config.vm.provision "shell", inline: <<-SHELL
    # Ajoutez ici des commandes de provisionnement si nécessaire
    echo "Provisionnement terminé"
  SHELL
end

```

```bash
[vagrant@rocky9 ~]$ ip
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
where  OBJECT := { address | addrlabel | amt | fou | help | ila | ioam | l2tp |
                   link | macsec | maddress | monitor | mptcp | mroute | mrule |
                   neighbor | neighbour | netconf | netns | nexthop | ntable |
                   ntbl | route | rule | sr | tap | tcpmetrics |
                   token | tunnel | tuntap | vrf | xfrm }
       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec | -j[son] | -p[retty] |
                    -f[amily] { inet | inet6 | mpls | bridge | link } |
                    -4 | -6 | -M | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -br[ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |
                    -c[olor]}
[vagrant@rocky9 ~]$ ss
Netid      State      Recv-Q      Send-Q                          Local Address:Port             Peer Address:Port       Process
u_dgr      ESTAB      0           0                         /run/systemd/notify 12590                       * 0
u_dgr      ESTAB      0           0                /run/systemd/journal/dev-log 12603                       * 0
u_dgr      ESTAB      0           0                 /run/systemd/journal/socket 12605                       * 0
u_dgr      ESTAB      0           0                    /run/chrony/chronyd.sock 18786                       * 0
u_dgr      ESTAB      0           0                                           * 22698                       * 22699
u_str      ESTAB      0           0                                           * 18976                       * 18977
u_str      ESTAB      0           0                                           * 20118                       * 20119
u_dgr      ESTAB      0           0                                           * 18726                       * 12603
u_dgr      ESTAB      0           0                                           * 19832                       * 12603
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19372                       * 19371
u_str      ESTAB      0           0                                           * 19470                       * 19477
u_str      ESTAB      0           0                                           * 18935                       * 19604
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 19304                       * 19301
u_str      ESTAB      0           0                                           * 18200                       * 18571
u_str      ESTAB      0           0                                           * 18727                       * 18728
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 18571                       * 18200
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 19287                       * 19284
u_dgr      ESTAB      0           0                                           * 18217                       * 18216
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19536                       * 18881
u_str      ESTAB      0           0                                           * 18947                       * 18956
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 19229                       * 19228
u_dgr      ESTAB      0           0                                           * 20418                       * 12603
u_str      ESTAB      0           0                                           * 19465                       * 19466
u_str      ESTAB      0           0                                           * 19284                       * 19287
u_dgr      ESTAB      0           0                                           * 18480                       * 12590
u_str      ESTAB      0           0                                           * 22736                       * 22737
u_str      ESTAB      0           0                                           * 19228                       * 19229
u_str      ESTAB      0           0                                           * 20513                       * 20514
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 19461                       * 18428
u_dgr      ESTAB      0           0                                           * 20498                       * 12603
u_dgr      ESTAB      0           0                                           * 12592                       * 12591
u_str      ESTAB      0           0                                           * 19371                       * 19372
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19477                       * 19470
u_dgr      ESTAB      0           0                                           * 18135                       * 12605
u_dgr      ESTAB      0           0                                           * 22733                       * 12603
u_str      ESTAB      0           0                                           * 22327                       * 0
u_str      ESTAB      0           0                                           * 22702                       * 22703
u_str      ESTAB      0           0                                           * 12695                       * 12751
u_str      ESTAB      0           0                                           * 20511                       * 20512
u_str      ESTAB      0           0                                           * 19466                       * 19465
u_str      ESTAB      0           0                                           * 18756                       * 19479
u_dgr      ESTAB      0           0                                           * 18216                       * 18217
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 20342                       * 20341
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 18956                       * 18947
u_dgr      ESTAB      0           0                                           * 22681                       * 12605
u_dgr      ESTAB      0           0                                           * 12591                       * 12592
u_str      ESTAB      0           0                                           * 19513                       * 18801
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19479                       * 18756
u_str      ESTAB      0           0                                           * 20512                       * 20511
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19160                       * 19159
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 12751                       * 12695
u_str      ESTAB      0           0                                           * 22737                       * 22736
u_str      ESTAB      0           0                                           * 18881                       * 19536
u_str      ESTAB      0           0                                           * 19301                       * 19304
u_dgr      ESTAB      0           0                                           * 22410                       * 12603
u_str      ESTAB      0           0                                           * 18728                       * 18727
u_dgr      ESTAB      0           0                                           * 18866                       * 12605
u_str      ESTAB      0           0                                           * 22389                       * 22665
u_dgr      ESTAB      0           0                                           * 19463                       * 12605
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 22703                       * 22702
u_dgr      ESTAB      0           0                                           * 18212                       * 12605
u_str      ESTAB      0           0                                           * 19159                       * 19160
u_str      ESTAB      0           0                                           * 20119                       * 20118
u_str      ESTAB      0           0                                           * 18428                       * 19461
u_dgr      ESTAB      0           0                                           * 22699                       * 22698
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 19604                       * 18935
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 18767                       * 19500
u_str      ESTAB      0           0                                           * 20341                       * 20342
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 22665                       * 22389
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 18977                       * 18976
u_str      ESTAB      0           0                 /run/dbus/system_bus_socket 20514                       * 20513
u_str      ESTAB      0           0                                           * 19500                       * 18767
u_str      ESTAB      0           0                 /run/systemd/journal/stdout 18801                       * 19513
u_dgr      ESTAB      0           0                                           * 18770                       * 12603
udp        ESTAB      0           0                              10.0.2.15%eth0:bootpc               10.0.2.2:bootps
tcp        ESTAB      0           0                                   10.0.2.15:ssh                  10.0.2.2:58393
[vagrant@rocky9 ~]$ nc
usage: nc [-46cDdFhklNnrStUuvz] [-C certfile] [-e name] [-H hash] [-I length]
          [-i interval] [-K keyfile] [-M ttl] [-m minttl] [-O length]
          [-o staplefile] [-P proxy_username] [-p source_port] [-R CAfile]
          [-s sourceaddr] [-T keyword] [-V rtable] [-W recvlimit] [-w timeout]
          [-X proxy_protocol] [-x proxy_address[:port]] [-Z peercertfile]
          [destination] [port]
[vagrant@rocky9 ~]$ vim
[vagrant@rocky9 ~]$ dig

; <<>> DiG 9.16.23-RH <<>>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 21167
;; flags: qr rd ra; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1280
;; QUESTION SECTION:
;.                              IN      NS

;; ANSWER SECTION:
.                       189129  IN      NS      e.root-servers.net.
.                       189129  IN      NS      h.root-servers.net.
.                       189129  IN      NS      k.root-servers.net.
.                       189129  IN      NS      d.root-servers.net.
.                       189129  IN      NS      c.root-servers.net.
.                       189129  IN      NS      l.root-servers.net.
.                       189129  IN      NS      i.root-servers.net.
.                       189129  IN      NS      b.root-servers.net.
.                       189129  IN      NS      g.root-servers.net.
.                       189129  IN      NS      f.root-servers.net.
.                       189129  IN      NS      a.root-servers.net.
.                       189129  IN      NS      j.root-servers.net.
.                       189129  IN      NS      m.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.     124513  IN      AAAA    2001:503:ba3e::2:30
b.root-servers.net.     369540  IN      AAAA    2801:1b8:10::b
c.root-servers.net.     375215  IN      AAAA    2001:500:2::c
d.root-servers.net.     315712  IN      AAAA    2001:500:2d::d
e.root-servers.net.     462930  IN      AAAA    2001:500:a8::e
f.root-servers.net.     148454  IN      AAAA    2001:500:2f::f
g.root-servers.net.     462930  IN      AAAA    2001:500:12::d0d
h.root-servers.net.     369628  IN      AAAA    2001:500:1::53
i.root-servers.net.     213099  IN      AAAA    2001:7fe::53
j.root-servers.net.     192775  IN      AAAA    2001:503:c27::2:30
k.root-servers.net.     369628  IN      AAAA    2001:7fd::1
l.root-servers.net.     221387  IN      AAAA    2001:500:9f::42
m.root-servers.net.     172849  IN      AAAA    2001:dc3::35
a.root-servers.net.     89523   IN      A       198.41.0.4
b.root-servers.net.     284710  IN      A       170.247.170.2
c.root-servers.net.     159214  IN      A       192.33.4.12
d.root-servers.net.     163532  IN      A       199.7.91.13
e.root-servers.net.     115449  IN      A       192.203.230.10
f.root-servers.net.     163532  IN      A       192.5.5.241
g.root-servers.net.     115449  IN      A       192.112.36.4
h.root-servers.net.     369628  IN      A       198.97.190.53
i.root-servers.net.     163532  IN      A       192.36.148.17
j.root-servers.net.     287717  IN      A       192.58.128.30
k.root-servers.net.     369628  IN      A       193.0.14.129
l.root-servers.net.     163532  IN      A       199.7.83.42
m.root-servers.net.     171946  IN      A       202.12.27.33

;; Query time: 52 msec
;; SERVER: 10.0.2.3#53(10.0.2.3)
;; WHEN: Thu Jan 11 20:42:15 UTC 2024
;; MSG SIZE  rcvd: 823

[vagrant@rocky9 ~]$
```

## 3. Moult VMs

🌞 **Adaptez votre `Vagrantfile`** pour qu'il lance les VMs suivantes (en réutilisant votre box de la partie précédente)

- vous devez utiliser une boucle for dans le `Vagrantfile`
- pas le droit de juste copier coller le même bloc trois fois, une boucle for j'ai dit !

| Name           | IP locale   | Accès internet | RAM |
| -------------- | ----------- | -------------- | --- |
| `node1.tp3.b2` | `10.3.1.11` | Ui             | 1G  |
| `node2.tp3.b2` | `10.3.1.12` | Ui             | 1G  |
| `node3.tp3.b2` | `10.3.1.13` | Ui             | 1G  |

📁 **`partie1/Vagrantfile-3A`** dans le dépôt git de rendu

🌞 **Adaptez votre `Vagrantfile`** pour qu'il lance les VMs suivantes (en réutilisant votre box de la partie précédente)

- l'idéal c'est de déclarer une liste en début de fichier qui contient les données des VMs et de faire un `for` sur cette liste
- à vous de voir, sans boucle `for` et sans liste, juste trois blocs déclarés, ça fonctionne aussi

| Name           | IP locale    | Accès internet | RAM |
| -------------- | ------------ | -------------- | --- |
| `alice.tp3.b2` | `10.3.1.11`  | Ui             | 1G  |
| `bob.tp3.b2`   | `10.3.1.200` | Ui             | 2G  |
| `eve.tp3.b2`   | `10.3.1.57`  | Nan            | 1G  |

📁 **`partie1/Vagrantfile-3B`** dans le dépôt git de rendu

> *La syntaxe Ruby c'est vraiment dégueulasse.*

