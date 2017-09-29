Title: libvirt-daemon-driver-storage bug in Centos 7
Category: tech
Tags: centos7,bug,centos,libvirt,kvm
Author: Maciej Lasyk
Summary: About annoying bug w/device-mapper

<center>![libvirt]({filename}/images/libvirt.png)</center>

# failed to load module libvirt_driver_storage.so #

Today I was installing
[virt-sysprep](http://libguestfs.org/virt-sysprep.1.html) tool on one of KVM
hosts. When this was done I couldn't list VMs anymore using **virsh**:

```bash
[root@host1 ~]# virsh list --all
[454/564]
 Id    Name                           State
 ----------------------------------------------------
```

Hmm that's not normal obsiously. Checked the **libvirtd** status:

```bash
[root@host1 ~]# service libvirtd status
Redirecting to /bin/systemctl status  libvirtd.service
libvirtd.service - Virtualization daemon
   Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; enabled)
   Active: active (running) since Mon 2015-04-06 15:43:55 CEST; 1h 16min ago
     Docs: man:libvirtd(8)
           http://libvirt.org
 Main PID: 21191 (libvirtd)
   CGroup: /system.slice/libvirtd.service
           ├─ 5865 /sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf
           └─21191 /usr/sbin/libvirtd

...
Apr 06 17:01:42 host1.devops.ent libvirtd[6254]: failed to load module 
/usr/lib64/libvirt/connection-driver/libvirt_driver_storage.so 
/usr/lib64/libvirt/connection-driver/libvirt_driver_storage.so: symbol 
dm_task_get_info_with_deferred_remove, version Base not defined in file 
libdevmapper.so.1.02 with link time reference
Apr 06 17:01:42 host1.devops.ent libvirtd[6254]: failed to load module 
/usr/lib64/libvirt/connection-driver/libvirt_driver_qemu.so 
/usr/lib64/libvirt/connection-driver/libvirt_driver_qemu.so: undefined 
symbol: virStorageFileCreate
...
```

I confirmed that installing **virt-sysprep** caused also upgrading libvirtd related packages:

```bash
 Updated     libvirt-1.1.1-29.el7_0.7.x86_64                         @updates
    Update              1.2.8-16.el7_1.2.x86_64                         @updates
    Updated     libvirt-client-1.1.1-29.el7_0.7.x86_64                  @updates
    Update                     1.2.8-16.el7_1.2.x86_64                  @updates
    Updated     libvirt-daemon-1.1.1-29.el7_0.7.x86_64                  @updates
    Update                     1.2.8-16.el7_1.2.x86_64                  @updates
    Updated     libvirt-daemon-config-network-1.1.1-29.el7_0.7.x86_64   @updates
    Update                                    1.2.8-16.el7_1.2.x86_64   @updates
    Updated     libvirt-daemon-config-nwfilter-1.1.1-29.el7_0.7.x86_64  @updates
    Update                                     1.2.8-16.el7_1.2.x86_64  @updates
    Updated     libvirt-daemon-driver-interface-1.1.1-29.el7_0.7.x86_64 @updates
    Update                                      1.2.8-16.el7_1.2.x86_64 @updates
    Updated     libvirt-daemon-driver-lxc-1.1.1-29.el7_0.7.x86_64       @updates
    Update                                1.2.8-16.el7_1.2.x86_64       @updates
    Updated     libvirt-daemon-driver-network-1.1.1-29.el7_0.7.x86_64   @updates
    Update                                    1.2.8-16.el7_1.2.x86_64   @updates
    Updated     libvirt-daemon-driver-nodedev-1.1.1-29.el7_0.7.x86_64   @updates
    Update                                    1.2.8-16.el7_1.2.x86_64   @updates
    Updated     libvirt-daemon-driver-nwfilter-1.1.1-29.el7_0.7.x86_64  @updates
    Update                                     1.2.8-16.el7_1.2.x86_64  @updates
    Updated     libvirt-daemon-driver-qemu-1.1.1-29.el7_0.7.x86_64      @updates
    Update                                 1.2.8-16.el7_1.2.x86_64      @updates
    Updated     libvirt-daemon-driver-secret-1.1.1-29.el7_0.7.x86_64    @updates
    Update                                   1.2.8-16.el7_1.2.x86_64    @updates
    Updated     libvirt-daemon-driver-storage-1.1.1-29.el7_0.7.x86_64   @updates
    Update                                    1.2.8-16.el7_1.2.x86_64   @updates
    Dep-Install libvirt-daemon-kvm-1.2.8-16.el7_1.2.x86_64              @updates
```

So once more I read the problematic log entry:

```bash
failed to load module /usr/lib64/libvirt/connection-driver/libvirt_driver_storage.so /usr/lib64/libvirt/connection-driver/libvirt_driver_storage.so: symbol dm_task_get_info_wit
h_deferred_remove, version Base not defined in file libdevmapper.so.1.02 with link time reference
```

and decided to **yum upgrade device-mapper-libs**. Afterwards I restarted **libvirtd**
and everything started working perfectly.

This would not happen if I had updated all the libraries, but unfortunately 
all I wanted was **virt-sysprep** installed - not update'ing all packages.

Finally [filed a bugrequest](http://bugs.centos.org/view.php?id=8403)
