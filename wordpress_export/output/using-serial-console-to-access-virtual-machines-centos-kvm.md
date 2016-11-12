Title: Using serial console to access virtual machines (Centos, KVM)
Date: 2013-01-09 22:06
Author: docent
Category: configuration, kvm, virtualization
Tags: console, kvm, serial, virsh, virtualization
Slug: using-serial-console-to-access-virtual-machines-centos-kvm
Status: published

<!--:en-->Last time I promised, that I'll write how to connect to VM via
serial console. So - this time very shortly and without any
explanations:

On the guest OS:

``` {.lang:default .decode:true .crayon-selected}
echo ttyS0 >> /etc/securetty
```

 

Now add following param to kernel params in **/etc/grub.conf**:

    console=ttyS0

And the last thing:

``` {.lang:default .decode:true}
echo "S0:12345:respawn:/sbin/agetty ttyS0 115200" >> /etc/inittab && init q
```

 

Now restart the guest OS and You're good to connct to VM via:

**virsh console guest\_id**

If You feel like interested in what happened above - please ask
questions in comments - I'll explain :)<!--:--><!--:pl-->W ostatnim
wpisie obiecałem, iż opiszę jakie czary-mary trzeba wykonać, aby móc się
podłączyć do VMki via **virsh console** (które to domyślnie zwraca
"czarny ekran"). Dziś w skrócie i bez objaśnień.

Na VMce:

``` {.lang:default .decode:true}
echo ttyS0 >> /etc/securetty
```

Następnie dodajemy poniższy wpis to parametrów kernela w
**/etc/grub.conf**:

    console=ttyS0

A następnie:

``` {.lang:default .decode:true}
echo "S0:12345:respawn:/sbin/agetty ttyS0 115200" >> /etc/inittab && init q
```

Restartujemy guesta i v'oila - możemy się łączyć z nim poprzez hosta za
pomocą konsoli:

***virsh console id\_guesta***

Jakby kogoś interesowało co tutaj zaszło to zapraszam do dyskusji w
komentarzach<!--:-->
