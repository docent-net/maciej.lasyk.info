Title: KVM - libvirt-guests - autostart / shutdown / pause
Date: 2013-04-29 11:40
Author: docent
Category: tech
Tags: kvm, virtualization, xen
Slug: kvm-libvirt-guests-autostart-shutdown-pause
Status: published

<!--:en-->Some time ago while using XEN we had our own scripts we used
during shutdown / start host machine. Those scripts were responsible for
auto - saving and auto - resuming VMs. In KVM we no longer use our own
scripts - we use **libvirt-guests** service instead. In RHEL/CentOS
You'll find init script for this service
in  **/etc/rc.d/init.d/libvirt-guests. If You want to do some changes in
this service's configuration do that in /etc/sysconfig/libvirt-guests
instead of init script. If You installed KVM env using defaults You'll
be interested only in following params:**

``` {.lang:sh .decode:true}
ON_BOOT=start
ON_SHUTDOWN=suspend
#START_DELAY=0
#PARALLEL_SHUTDOWN=0
#SHUTDOWN_TIMEOUT=300
```

Using above config Your VMs would be auto - paused while system enters
runlevel 0/6 (so shutdown or reboot). When host comes back ("back" means
runlevels in which libvirt-guests is configured) Your VMs will be
resumed.

Order of stopping / starting VMs is tricky - I found this discussion
interesting: <http://www.redhat.com/archives/libvir-list/2011-April/msg00819.html><!--:--><!--:pl-->W
czasach gdy używaliśmy XENa mieliśmy swoje skrypty, które zarządzały
gaszeniem / startem wirtualek w trakcie rebootu systemu na hoście.
Jednak w KVMie realizujemy to trochę inaczej. W skrócie wygląda to tak -
jest usługa **libvirt-guests**, która jest odpowiedzialna za gaszenie /
stawianie wirtualek po starcie i przy reboocie hosta. W RHEL/Centosie
jej skrypt startowy znajdziemy oczywiście
w **/etc/rc.d/init.d/libvirt-guests. Zamiast jednak edytować ten skrypt
bezpośrednio aby zmienić parametry konfiguracyjne lepiej dobrać się do**
**/etc/sysconfig/libvirt-guests** - w domyślnych ustawieniach instalacji
KVMa na RHEL/Centosie interesują nas na początek tylko poniższe
parametry:

``` {.lang:sh .decode:true}
ON_BOOT=start
ON_SHUTDOWN=suspend
#START_DELAY=0
#PARALLEL_SHUTDOWN=0
#SHUTDOWN_TIMEOUT=300
```

W powyższej konfiguracji VMki na hoście zostaną zapauzowane w momencie
gdy host przejdzie na runlevel 0/6 (czyli shutdown bądź reboot). W
trakcie gdy system hosta wstanie z powrotem (gdzie "z powrotem określa
runlevel, na którym startuje usługa libvirt-guests) VMki zostaną
przywrócone.

Odnośnie kolejności gaszenia / przywracania polecam
lekturę: <http://www.redhat.com/archives/libvir-list/2011-April/msg00819.html><!--:-->
