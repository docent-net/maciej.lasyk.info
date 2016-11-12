Title: How to change OVH kernel to normal Centos kernel
Date: 2012-12-23 13:54
Author: docent
Category: kernel
Tags: centos kernel ovh
Slug: how-to-change-ovh-kernel-to-normal-centos-kernel
Status: published

<!--:en-->I've just installed new OVH serwer on Centos 6.3. And I
spotted a problem - I couldn't install KVM services due to lack of KVM
kernel modules. And I wasn't abe to load them because this fresh
installation used some OVH kernel which was wiped out of those modues...

So I had two ways of solving this issue. Recompiling kernel from scratch
and adding KVM modules (long way - and what for? It just consumes so
much time...) or.. just revert stock Centos kernel :) And this was the
way I chose.

Whole procedure is just trivial. Firsth thing - let's install new kernel
(stok one) with yum::

    [root@ks3283784 ~]# yum install kernel
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirror.ovh.net
     * extras: mirror.ovh.net
     * updates: mirror.ovh.net
    base                                                                                                                                             | 3.7 kB     00:00     
    extras                                                                                                                                           | 3.5 kB     00:00     
    updates                                                                                                                                          | 3.5 kB     00:00     
    Setting up Install Process
    Package kernel-2.6.32-279.19.1.el6.x86_64 already installed and latest version
    Nothing to do

When installed, we need to include it in the boot loader - which is Grub
by default in Centos. In order to do it properly, we have to know our
kernel version (so this one we're given after **yum install
kernel** command, so: **kernel-2.6.32-279.19.1.el6.x86\_64** in my case
and the device, which hosts our root partition - we can check this with
**mount** command and the contents of **/etc/fstab** directory:

    /dev/md1       /        ext4    errors=remount-ro       0       1
    /dev/md2        /home   ext4    defaults        0       2
    /dev/sda3       none    swap    defaults        0       0
    /dev/sdb3       none    swap    defaults        0       0

Above we see that **/** directory is hosted on **/dev/md1** device. So
now we can modify **/boot/grub/grub.conf**:

>     default=0
>     timeout=5
>             title linux centos6_64
>             root (hd0,0)
>             kernel /boot/vmlinuz-2.6.32-279.19.1.el6.x86_64 root=/dev/md1
>             initrd /boot/initramfs-2.6.32-279.19.1.el6.x86_64.img

Now after double-check we just reboot our system and wait.. If it's up
then let's be sure, that we got our stock centos kernel:

    [root@ks3283784 ~]# uname -r
    2.6.32-279.19.1.el6.x86_64

So we're good :) If for some reason server is not coming back after
reboot then We can rescue it by booting it into rescue-mode in OVH
manager. Then we need to replace **/boot/grub/grub.conf** with our
backup **/boot/grub/grub.conf.bak**<!--:--><!--:pl-->Zainstalowałem nowy
serwer w OVH na Centosie 6.3. I po raz kolejny miałem problem, gdyż
używa on jądra przygotowanego przez OVH, które to nie posiada modułów
kvmowych do obsługi wirtualizacji.

Wyjścia z sytuacji są dwa - można rekompilować jądro OVH i dodać
wymagane moduły samemu (co jest delikatnie upierdliwe - rekompilacja
jądra w Centosie jest passé i zabiera trochę czasu) albo po prostu
przywrócić stare jądro - i tą drogą poszedłem.

W zasadzie procedura jest trywialna. Pierwsza sprawa - zainstalujmy
najnowsze jądro yumem:

    [root@ks3283784 ~]# yum install kernel
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirror.ovh.net
     * extras: mirror.ovh.net
     * updates: mirror.ovh.net
    base                                                                                                                                             | 3.7 kB     00:00     
    extras                                                                                                                                           | 3.5 kB     00:00     
    updates                                                                                                                                          | 3.5 kB     00:00     
    Setting up Install Process
    Package kernel-2.6.32-279.19.1.el6.x86_64 already installed and latest version
    Nothing to do

Mając już zainstalowane nowe jądro trzeba je podpiąć pod loadera, czyli
gruba. Aby to poprawnie zrobić musimy znać wersje jądra, którą chcemy
użyć (to ten numer uzyskany w trakcie operacji **yum install kernel**,
czyli w moim przypadku** kernel-2.6.32-279.19.1.el6.x86\_64** oraz
urządzenie, z którego podpięta jest root-partycja - to możemy sprawdzić
za pomocą zawartości **/etc/fstab** czy też komendy **mount**.
Przykładowo u mnie zawartość fstaba:

    /dev/md1       /        ext4    errors=remount-ro       0       1
    /dev/md2        /home   ext4    defaults        0       2
    /dev/sda3       none    swap    defaults        0       0
    /dev/sdb3       none    swap    defaults        0       0

Z czego wynika, że katalog **/** jest montowany z urządzenia
**/dev/md1** (mam tu raida software'owego; dodatkowo popatrzcie jak
bezmyślnie jest ułożony domyślny układ partycji - zupełnie jak na
desktopie - tego tutaj nie widać, ale /home posiada 98% przestrzenie
dyskowej).

Wróćmy do meritum. Mając już wersję jądra
(**kernel-2.6.32-279.19.1.el6.x86\_64b** oraz uchwyt urządzenia, na
którym jest podmontowany katalog **/** (**/dev/md1**) możemy przystąpić
do modyfikacji konfiguracji gruba **/boot/grub/grub.conf**:

>     default=0
>     timeout=5
>             title linux centos6_64
>             root (hd0,0)
>             kernel /boot/vmlinuz-2.6.32-279.19.1.el6.x86_64 root=/dev/md1
>             initrd /boot/initramfs-2.6.32-279.19.1.el6.x86_64.img

Na powyższym wytłuściłem to co pewnie będziemy musieli ustawić
poprawnie. Możemy też po prostu kompletnie wyrzucić
**/boot/grub/grub.conf** i go zastąpić powyższym lecz z Waszymi danymi.

Teraz w zasadzie pozostaje nam double-check wszystkiego co zmieniliśmy i
reboot. Jak wstaje to jeszcze szybko sprawdzamy co mamy:

    [root@ks3283784 ~]# uname -r
    2.6.32-279.19.1.el6.x86_64

Czyli jesteśmy w domu. Jakby serwer jednak nie wstawał to pozostaje nam
wejście w panel OVH i reboot serwera w trybie rescue, w którym to
podmieniamy **/boot/grub/grub.conf** backupem,
czyli **/boot/grub/grub.conf.bak**<!--:-->
