Title: SELinux / sVirt vs Venom vulnerability
Category: tech
Tags: kvm,libvirt,selinux,sirt,security,qemu
Author: Maciej Lasyk
Summary: How does SELinux protect us against Venom?

<center>![libvirt]({filename}/images/venom.png)</center>

# Venom? #

Basically it's a vulnerability that may be used to escape hypervisor (Qemu
based, e.g. KVM. XEN) and obtain root permissions on host machine (and from
that on also other virtual machines).

This vulnerability has interesting PR - nice logo, name and a website
:O Real triplet of security marketing: [Venom
webpage](http://venom.crowdstrike.com/)

Also check [RedHat article on this
CVE](https://access.redhat.com/articles/1444903)

# Am I fucked? #

Maybe. If you're using Qemu driver then you might have a problem...

...but...

... **not when using SELinux / sVirt**

With [sVirt](http://www.selinuxproject.org/page/SVirt) and SELinux securing
your system [you should sleep
well](https://securityblog.redhat.com/2015/05/13/venom-dont-get-bitten/). 
Because even if attacker successfully escapes hypervisor confinement he will be
still under the dome of SELinux confinement (which by default is set to
**system_u:system_r:svirt_t**; 


But **should** may not be enough. So I'm gonna say this - you **can** sleep
well thanks to MCS (Multi-Level security) & MLC (Multi-Category security) 
in SELinux.

What I wrote above tells us that every virtual machine has **svirt_t** security
type by default. This is a confinement configuration for each VM. And there is
more. Each virtualized guest process is labeled and runs with a dynamically 
generated level. Each process is isolated from other VMs with different MCS 
levels. Example from one of my boxes:

```bash
system_u:system_r:svirt_t:s0:c14,c894
system_u:system_r:svirt_t:s0:c393,c652
system_u:system_r:svirt_t:s0:c730,c767
system_u:system_r:svirt_t:s0:c465,c623
system_u:system_r:svirt_t:s0:c246,c630
system_u:system_r:svirt_t:s0:c37,c395
system_u:system_r:svirt_t:s0:c225,c437
system_u:system_r:svirt_t:s0:c40,c846
system_u:system_r:svirt_t:s0:c523,c530
system_u:system_r:svirt_t:s0:c361,c630
system_u:system_r:svirt_t:s0:c63,c827
system_u:system_r:svirt_t:s0:c52,c133
system_u:system_r:svirt_t:s0:c416,c722
system_u:system_r:svirt_t:s0:c36,c814
system_u:system_r:svirt_t:s0:c615,c661
system_u:system_r:svirt_t:s0:c96,c792
system_u:system_r:svirt_t:s0:c60,c74
system_u:system_r:svirt_t:s0:c492,c659
system_u:system_r:svirt_t:s0:c72,c693
system_u:system_r:svirt_t:s0:c499,c536
```

This is just a slice. As you can see each process (VM) has other MLC.

# Solution? #

Yup - even SELinux might have some security vulnerabilities we don't know about
so it's better to fix Qemu. How? Simply:

```bash
yum update qemu-kvm
```

(or update all pkgs - whatever)

EDIT: [Dan Walsh confirmed](http://danwalsh.livejournal.com/71489.html) that Venom is not an issue w/ SELinux enabled.
