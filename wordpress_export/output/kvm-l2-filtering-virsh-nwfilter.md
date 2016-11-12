Title: KVM L2 filtering / virsh nwfilter
Date: 2013-12-01 22:24
Author: docent
Category: virtualization
Tags: arp, dhcp, ebtables, kvm, netfilter, networking
Slug: kvm-l2-filtering-virsh-nwfilter
Status: published

<!--:en-->[![KVM](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/kvmbanner-logo2.png){.aligncenter
.size-full .wp-image-428 width="300"
height="93"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/kvmbanner-logo2.png)

A few days ago while deploying another KVM host (this time in Hetzner.de
datacenter) I had to lurk into deep networking internals. Hetzner has
port security enabled on switches' ports so there's no way to use
classical L2 bridging in netfilter. But i'll write another post about
resolving this one (yup, I did it - might be also usable for OVH users)
;)

This time I wanted to write a short post about network security in KVM
host. Especially about ARP/IP spoofing. Problem? By default VMs can
easily attack each other by spoofing each others MAC / IP addrs.
Normally those type of attacks are mitigated on L2 - so we use e.g. port
security, storm control, secure-arp-table and so on (sorry Juniper, I'm
pure Cisco). So we know that L2 switch can be easily simulated on
software side with netfilter / bridging. It's easy to create network
bridge, but it's harder to create security policy for L2. And aAll that
has to be done is to turn on ebtables and create some rules.

And here KVM / libvirt appears as very helpful. Writing ebtables rules
is not a rocket science, but when managing multiple VMs it's really easy
to handle those with some higher - level tool. I ended up adding some
rules to VMs' XML definitions:

``` {.lang:default .decode:true}
    <interface type='network'>
      <mac address='52:54:00:xx:yy:zz'/>
      <source network='routed'/>
      <model type='virtio'/>
      <filterref filter='clean-traffic'>
        <parameter name='IP' value='88.99.11.22'/>
      </filterref>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
    </interface>
```

So above you can see the "clean traffic" filter. What is that? Here a
little explanation:

``` {.lang:default .decode:true}
[root@cubryna qemu]# virsh nwfilter-dumpxml clean-traffic
<filter name='clean-traffic' chain='root'>
  <uuid>2c7bbeb3-1438-zzz-yyy-xxx</uuid>
  <filterref filter='no-mac-spoofing'/>
  <filterref filter='no-ip-spoofing'/>
  <rule action='accept' direction='out' priority='-650'>
    <mac protocolid='ipv4'/>
  </rule>
  <filterref filter='allow-incoming-ipv4'/>
  <filterref filter='no-arp-spoofing'/>
  <rule action='accept' direction='inout' priority='-500'>
    <mac protocolid='arp'/>
  </rule>
  <filterref filter='no-other-l2-traffic'/>
  <filterref filter='qemu-announce-self'/>
</filter>
```

So basically "clean traffic" is a group of predefined filter references.
Please read the libvirt documentation for details. Brief explanation
would be: if clean traffic is applied on VM than such an VM will not be
able to spoof MAC or IP addr (and some more rules as you can see above).

One could ask - why the heck didn't I configured DHCP and instead of
that I put static IP addr into VM XML config file? So - DHCP is great,
but when you want to enable migration for VMs than before new host
learns new VMs IP addr / MAC this VM can easily spoof it. So - it's
better to place IP into XML file.

Reference:

-   <span
    style="line-height: 13px;"><http://libvirt.org/formatnwfilter.html>  
   </span>
-   <https://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html-single/Virtualization_Deployment_and_Administration_Guide/index.html>
-   <https://events.linuxfoundation.org/slides/2011/lfcs/lfcs2011_cloud_kashyap.pdf>
-   <https://www.berrange.com/tags/ip-spoofing/>

<!--:--><!--:pl-->

-   [![KVM](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/kvmbanner-logo2.png){width="300"
    height="93"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/kvmbanner-logo2.png)

    A few days ago while deploying another KVM host (this time in
    Hetzner.de datacenter) I had to lurk into deep networking internals.
    Hetzner has port security enabled on switches' ports so there's no
    way to use classical L2 bridging in netfilter. But i'll write
    another post about resolving this one (yup, I did it - might be also
    usable for OVH users) ;)

    This time I wanted to write a short post about network security in
    KVM host. Especially about ARP/IP spoofing. Problem? By default VMs
    can easily attack each other by spoofing each others MAC / IP addrs.
    Normally those type of attacks are mitigated on L2 - so we use e.g.
    port security, storm control, secure-arp-table and so on (sorry
    Juniper, I'm pure Cisco). So we know that L2 switch can be easily
    simulated on software side with netfilter / bridging. It's easy to
    create network bridge, but it's harder to create security policy
    for L2. And aAll that has to be done is to turn on ebtables and
    create some rules.

    And here KVM / libvirt appears as very helpful. Writing ebtables
    rules is not a rocket science, but when managing multiple VMs it's
    really easy to handle those with some higher - level tool. I ended
    up adding some rules to VMs' XML definitions:

            <interface type='network'>
              <mac address='52:54:00:xx:yy:zz'/>
              <source network='routed'/>
              <model type='virtio'/>
              <filterref filter='clean-traffic'>
                <parameter name='IP' value='88.99.11.22'/>
              </filterref>
              <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
            </interface>

    So above you can see the "clean traffic" filter. What is that? Here
    a little explanation:

        [root@cubryna qemu]# virsh nwfilter-dumpxml clean-traffic
        <filter name='clean-traffic' chain='root'>
          <uuid>2c7bbeb3-1438-zzz-yyy-xxx</uuid>
          <filterref filter='no-mac-spoofing'/>
          <filterref filter='no-ip-spoofing'/>
          <rule action='accept' direction='out' priority='-650'>
            <mac protocolid='ipv4'/>
          </rule>
          <filterref filter='allow-incoming-ipv4'/>
          <filterref filter='no-arp-spoofing'/>
          <rule action='accept' direction='inout' priority='-500'>
            <mac protocolid='arp'/>
          </rule>
          <filterref filter='no-other-l2-traffic'/>
          <filterref filter='qemu-announce-self'/>
        </filter>

    So basically "clean traffic" is a group of predefined
    filter references. Please read the libvirt documentation
    for details. Brief explanation would be: if clean traffic is applied
    on VM than such an VM will not be able to spoof MAC or IP addr (and
    some more rules as you can see above).

    One could ask - why the heck didn't I configured DHCP and instead of
    that I put static IP addr into VM XML config file? So - DHCP is
    great, but when you want to enable migration for VMs than before new
    host learns new VMs IP addr / MAC this VM can easily spoof it. So -
    it's better to place IP into XML file.

    Reference:

    -   <http://libvirt.org/formatnwfilter.html>
    -   <https://docs.fedoraproject.org/en-US/Fedora_Draft_Documentation/0.1/html-single/Virtualization_Deployment_and_Administration_Guide/index.html>
    -   <https://events.linuxfoundation.org/slides/2011/lfcs/lfcs2011_cloud_kashyap.pdf>
    -   <https://www.berrange.com/tags/ip-spoofing/>

<!--:-->
