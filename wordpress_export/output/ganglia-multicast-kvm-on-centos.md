Title: Ganglia, multicast && KVM on CentOS
Date: 2013-08-09 15:54
Author: docent
Category: monitoring
Tags: firewall, ganglia, gmetad, gmond, kvm
Slug: ganglia-multicast-kvm-on-centos
Status: published

<!--:en-->

[![http://ganglia.sourceforge.net](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/logo_small.jpg){.aligncenter
.size-full .wp-image-346 width="252"
height="115"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/logo_small.jpg)

This is just a short note - I have to post it as this problem was really
annoying and I couldn't find any solutions in Google, so had to resolve
it by myself.

Don't know what Ganglia is? Check
here: <http://ganglia.sourceforge.net/> - it just kicks ass :)

Problem? I installed **gmond** on all our hosts / guests (CentOS 5/6,
KVM virt, latest Ganglia daemons), also configured properly **gmetad**
daemons and started this whole stuff using multicast. And it was working
- for a while. After about 10-20 minutes it just stopped working on KVM
guests. I saw no charts for those machines - but gmonds (even in debug
mode) didn't reveal any problems. And KVM hosts' charts were fine
(mostly..).

One more thing - in KVM guests I always set "deaf = yes" (just don't
want to have too much multicast traffic - i set it to "no" only on some
bare hosts).

Ok so the problem.. I hung for some time on tcpdump / strace and came to
the root of this problem - somehow there was no multicast traffic on KVM
guests (I turned off iptables on KVM guests for the time of this whole
issue - resolving). After some time I found 2 possible root causes:

1.  <span style="line-height: 13px;"><span style="line-height: 13px;">On
    KVM hosts by default there is multicast filter set
    on: **no-ip-multicast** (You can check if You have it turned on with
    following command: </span></span>

    ``` {.lang:default .decode:true}
    virsh nwfilter-list | grep 'no-ip-multicast'
    ```

    If it's turned on - You can turn it off with:

    ``` {.lang:default .decode:true}
    virsh nwfilter-undefine no-ip-multicast
    service libvirtd restart
    ```

    <p>
    And that should do this part of the trick

2.  And also - on CentOS KVM guests we have to turn off rp\_filter in
    /etc/sysctl.conf:

    ``` {.lang:default .decode:true}
    net.ipv4.conf.default.rp_filter = 0
    ```

    and:

    ``` {.lang:default .decode:true}
    sysctl -p
    ```

    <p>
    (You can try setting it to "loose mode" (so value: 2) instead of 0 -
    it can work for You and it's always safer

Thats all for now. My sources for this one?

-   <span style="line-height: 22px;">Always in use: tcpdump /
    strace ;)</span>
-   Oh my - KVM why do you do this for me ("for security You fool!")?
    About KVM firewall: <http://libvirt.org/firewall.html>
-   More about security and
    rp\_filter: <https://access.redhat.com/site/solutions/53031>
-   And this nice RFC: <http://www.ietf.org/rfc/rfc3704.txt>

<!--:--><!--:pl-->[![http://ganglia.sourceforge.net](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/logo_small.jpg){width="252"
height="115"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/logo_small.jpg)

This is just a short note - I have to post it as this problem was really
annoying and I couldn't find any solutions in Google, so had to resolve
it by myself.

Don't know what Ganglia is? Check
here: <http://ganglia.sourceforge.net/> - it just kicks ass :)

Problem? I installed **gmond** on all our hosts / guests (CentOS 5/6,
KVM virt, latest Ganglia daemons), also configured
properly **gmetad** daemons and started this whole stuff using
multicast. And it was working - for a while. After about 10-20 minutes
it just stopped working on KVM guests. I saw no charts for those
machines - but gmonds (even in debug mode) didn't reveal any problems.
And KVM hosts' charts were fine (mostly..).

One more thing - in KVM guests I always set "deaf = yes" (just don't
want to have too much multicast traffic - i set it to "no" only on some
bare hosts).

Ok so the problem.. I hung for some time on tcpdump / strace and came to
the root of this problem - somehow there was no multicast traffic on KVM
guests (I turned off iptables on KVM guests for the time of this whole
issue - resolving). After some time I found 2 possible root causes:

1.  On KVM hosts by default there is multicast filter set
    on: **no-ip-multicast** (You can check if You have it turned on with
    following command:

        virsh nwfilter-list | grep 'no-ip-multicast'

    If it's turned on - You can turn it off with:

        virsh nwfilter-undefine no-ip-multicast
        service libvirtd restart

    <p>
    And that should do this part of the trick

2.  And also - on CentOS KVM guests we have to turn off rp\_filter in
    /etc/sysctl.conf:

        net.ipv4.conf.default.rp_filter = 0

    and:

        sysctl -p

    <p>
    (You can try setting it to "loose mode" (so value: 2) instead of 0 -
    it can work for You and it's always safer

Thats all for now. My sources for this one?

-   Always in use: tcpdump / strace ;)
-   Oh my - KVM why do you do this for me ("for security You fool!")?
    About KVM firewall: <http://libvirt.org/firewall.html>
-   More about security and
    rp\_filter: <https://access.redhat.com/site/solutions/53031>
-   And this nice RFC: <http://www.ietf.org/rfc/rfc3704.txt>

<!--:-->
