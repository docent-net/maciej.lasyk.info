Title: Installing KVM guest OS via VNC over SSH tunnel
Date: 2013-01-03 20:59
Author: docent
Category: ssh, virtualization
Tags: kvm, ssh, vnc
Slug: installing-kvm-guest-os-via-vnc-over-ssh-tunnel
Status: published

<!--:en-->Verry merry and christmas is over. And I've bought myself a
brand new server for this occasion :D So this is it - enough of
doing-nothing or not-doing-anything and I had to start migrating
services from the old box. And as old machine is just bare-metal env,
where users kill each other for memory, than I decided - no more. KVM,
cgroups and hell with ya guys - You won't ever know about each other!
And all this for the same price (as the old box has 2 years and I paid
the same price for the new one, where I've got 8x more RAM, 2x more
storage and some quad-core...).

Ok enough of this talking. So I've got clean CentOS 6.3 installation
with basic KVM environment and SELinux set to Permissive mode (You could
leave it in Enforcing, having to "**chcon
--reference /var/lib/libvirt/images /your/vm/repodir**" - but i see no
point in using SELinux in host OS - this would eat to much resources,
and is at all not needed - what you have to do on host OS for security
is using very strict rules.

So... Centos, KVM, Permissive and We're ready to engage. For lazy guys I
suggest using Virtual Manger (**virt-manager**) where You can click
through the whole guest configuration process (for making this work You
should turn off iptables for a while or open some **virt-manager** TCP
ports). But as virt-manager is for lame, then we write on the terminal:

    [root@cubryna iso]# virt-install -r 2048 --accelerate -n VM-docent --disk path=/vm/VM-docent/VM-docent.img,size=50 --cdrom CentOS-6.3-x86_64-minimal.iso --vcpus=2  --vnc --os-type linux --hvm --vncport=65322

    Starting install...
    Creating storage file VM-docent.img                         |  50 GB     00:00     
    Creating domain...                                          |    0 B     00:00     
    Cannot open display: 
    Run 'virt-viewer --help' to see a full list of available command line options
    Domain installation still in progress. You can reconnect to 
    the console to complete the installation process.

And installation is running. Now We'd like to connect to it - so VNC
FTW! But...

    [root@cubryna iso]# netstat -nlp | grep 65322
    tcp        0      0 127.0.0.1:65322             0.0.0.0:*                   LISTEN      12768/qemu-kvm

VNC daemon is safely listening only on localhost, so We have to try some
different way. We could make this daemon to listen also on WAN
interface, but this would be to lame and risky. So we create SSH tunnel:

    [docent@docent-toshiba ~]$ ssh -p 65234 docent@cubryna.makaronzserem.eu -L 65322:127.0.0.1:65322
    RSA host key for IP address '5.135.178.98' not in list of known hosts.
    Last login: Thu Jan  3 20:26:48 2013 from neostradaaa
    CentOS release 6.3 (Final)
    Linux cubryna.makaronzserem.eu 2.6.32-279.19.1.el6.x86_64 #1 SMP Wed Dec 19 07:05:20 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

    ip        : 5.135.178.98
    hostname  : cubryna.makaronzserem.eu

    [docent@cubryna ~]$

And just after that We can safely connect our VNC client (like
Tiger-VNC) to our installation process using host **127.0.0.1:65322** :)

Of course after successfull installation I suggest creating clone of our
brand-new VPS just to save some time for future installations - use
**virt-clone** command to do this.

And that's all for now - next time I'll write how to configure guest OS
to make it possible to use **virsh console** command to connect to it
via serial console.<!--:--><!--:pl-->Po świątecznych zakupach doszedłem
do wniosku, że w końcu nadszedł czas na migrację serwisów ze starego
serwera na nowy. A nowy to w końcu środowisko wirtualne oparte na KVMie
- do widzenia użeranie się między użytkownikami i wspólne podbieranie
zasobów. KVM + cgroups zabijają system pod tym względem :)

Ale do rzeczy. Mam czystego hosta z oprogramowaniem KVMowym. SELinux
jest w trybie Permissive (choć wystarczyłoby nam do instalacji guesta
"**chcon --reference /var/lib/libvirt/images /nowy/dir/dla/vmek**",
jednak szkoda mi tutaj trochę zasobów a SELinux na hoście to imo troszkę
paranoja - tu przecież wystarczy surowa polityka bezpieczeństwa).

Wróćmy do tematu.. jest więc host, jest tryb Permissive, są paczki
KVMowe i host gotowy do instalacji VPSów czy też guestów. Dla leniwych
mamy "Virtual Managera" w Fedorze (**virt-manager**) - wystarczy go
podpiąć pod naszego hosta (leniwie wyłączając na moment iptables albo
otwierając co trzeba). Ale **virt-manager** nie jest koszerny, więc
piszemy:

    [root@cubryna iso]# virt-install -r 2048 --accelerate -n VM-docent --disk path=/vm/VM-docent/VM-docent.img,size=50 --cdrom CentOS-6.3-x86_64-minimal.iso --vcpus=2  --vnc --os-type linux --hvm --vncport=65322

    Starting install...
    Creating storage file VM-docent.img                         |  50 GB     00:00     
    Creating domain...                                          |    0 B     00:00     
    Cannot open display: 
    Run 'virt-viewer --help' to see a full list of available command line options
    Domain installation still in progress. You can reconnect to 
    the console to complete the installation process.

Instalacja uruchomiona. Teraz chcielibyśmy się pod nią podłączyć i coś
podziałać. VNC FTW - ale, że jak widać:

    [root@cubryna iso]# netstat -nlp | grep 65322
    tcp        0      0 127.0.0.1:65322             0.0.0.0:*                   LISTEN      12768/qemu-kvm

Demon VNC jest bezpiecznie podbindowany pod localhosta, tak też z
zewnątrz się tutaj nie dobijemy. Nie bawiąc się w zmuszanie VNC do
słuchania na zewnętrznym interfejsie (co nie jest ani koszerne ani
bezpieczne) po prostu tworzymy tunel SSH:

    [docent@docent-toshiba ~]$ ssh -p 65234 docent@cubryna.makaronzserem.eu -L 65322:127.0.0.1:65322
    RSA host key for IP address '5.135.178.98' not in list of known hosts.
    Last login: Thu Jan  3 20:26:48 2013 from neostradaaa
    CentOS release 6.3 (Final)
    Linux cubryna.makaronzserem.eu 2.6.32-279.19.1.el6.x86_64 #1 SMP Wed Dec 19 07:05:20 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

    ip        : 5.135.178.98
    hostname  : cubryna.makaronzserem.eu

    [docent@cubryna ~]$

I w ten oto piękny sposób mamy tunelowane połączenie z naszym serwerem
VNC. Uruchamiamy już tylko klienta VNC typu Tiger-VNC, łączymy się z
hostem **127.0.0.1:65322** i jesteśmy w domu - powinniśmy ujrzeć okienko
instalacji :)

Oczywiście instalację taką jak powyżej robimy rzadko. Z lenistwa i
oszczędności czasu polecam utworzyć z niej obraz i później już
**virt-clone**. Następnym razem napiszę jakie cudo trzeba zmontować aby
taki guest potrafił się komunikować za pomocą konsoli serialowej z
hostem - to też przydatne bo przecież nie będziemy utrzymywać VNC dla
każdego guesta... chyba, że lubisz ;)<!--:-->
