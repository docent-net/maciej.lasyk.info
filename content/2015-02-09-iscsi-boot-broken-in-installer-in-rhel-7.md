Title: iSCSI boot in RHEL/CentOS7 broken
Category: tech
Tags: rhel,centos,iscsi,boot,netboot
Author: Maciej Lasyk
Summary: How to fix the iSCSI boot issue in RHEL/CentOS 7

<center>![RHEL]({filename}/images/rhel-logo.png)</center>

### WAT? ###

Today while rolling up new host in my company I hit the following issue after
successfully installing CentOS7 on remote iSCSI drive. I just rebootted the
machine and after GRUB done it's job I just got:

```bash
[   2.375332] i8042: No controller found
[   2.592960] dracut: FATAL: For argument 
    'ip=::::localhost.localdomain:eno1: none'\nValue 'none' 
    without static configuration does not make sanse
[   2.593074] dracut: Refusing to continue
[   3.197719] System halted.
```

### What's that? ###

The answer is [here](https://access.redhat.com/solutions/905003). Simply
installer is broken and it creates broken grub entry for iSCSI nodes.

### How to fix this? ###

There're many ways. I just rebooted the box, entered the grub edit mode and
fixed the boot param replacing:

```bash
linux16 /vmlinuz-3.10.0-123.el7.x86_64 [...] 
    vconsole.font=latarcyrheb-sun16 
    ip=::::localhost.localdomain:eno1:none [...]
```

with this:

```bash
linux16 /vmlinuz-3.10.0-123.el7.x86_64 [...] 
    vconsole.font=latarcyrheb-sun16 
    ip=192.168.1.15::192.168.1.1:255.255.252.0:localhost.localdomain:eno1:none [...]
```

Where **192.168.1.15** is the initiator IP addr and **192.168.1.1** is the 
gateway IP.

Of course that above is just a way to successfully boot into the system. After 
boot the grub2.cfg is still broken so now it's the time for a permanent
solution:

- Fix above again in **/etc/sysconfig/grub**
- Rebuild the grub configuration: ***grub2-mkconfig -o /boot/grub2/grub.cfg***
- That's all. Just reboot and confirm it's working fine
