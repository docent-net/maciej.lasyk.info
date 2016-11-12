Title: SELinux && Ganglia / Multicast && Apache && RRDs
Date: 2013-09-29 21:10
Author: docent
Category: security
Tags: apache, ganglia, gmetad, gmond, gweb, httpd, rrd, selinux
Slug: selinux-ganglia-multicast-apache-rrds
Status: published

<!--:en-->

[![SELinux](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/09/post-38-pinguim-do-selinux.jpg){.aligncenter
.size-full .wp-image-357 width="200"
height="181"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/09/post-38-pinguim-do-selinux.jpg)While
setting up test server with Ganglia triad (gmetad, gmond, gweb over
Apache) I had only 2 SELinux alerts to solve. First one regarding to
denial of /var/lib/ganglia/rrd access by httpd process (while accessing
ganglia-web interface):

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .wrap-toggle:false .lang:default .decode:true}
type=AVC msg=audit(1380480812.081:1792): avc:  denied  { setattr } for  pid=5876 comm="rrdtool" name="fontconfig" dev=dm-1 ino=47054911 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=system_u:object_r:fonts_cache_t:s0 tclass=dir
```

In order to resolve that I just added SELinux contexts to rrdtool binary
and /var/lib/ganglia/rrds dir:

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .lang:default .decode:true}
chcon -t httpd_sys_script_exec_t /usr/bin/rrdtool
chcon -t httpd_sys_content_t /var/lib/ganglia/rrds -R
```

The last SELinux alert was regarding to Apache trying to access port
8652 by socket connection (on ganglia-web I saw error like "fsockopen
8652 access denied"):

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .lang:default .decode:true}
type=AVC msg=audit(1380480626.847:1764): avc:  denied  { name_connect } for  pid=2016 comm="httpd" dest=8652 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=system_u:object_r:port_t:s0 tclass=tcp_socket
```

So I had to create local policy for this particular occasion as there is
no ganglia modules for SELinux (maybe I should create one...?). Firstly
let's check that there's no even one module:

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .lang:default .decode:true}
[root@netrunner audit]# semodule -l | egrep -i "(ganglia|gmond|gmetad|gweb)" | wc -l
0
```

So let's create this policy:

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .lang:default .decode:true}
[root@netrunner audit]# grep httpd /var/log/audit/audit.log | audit2allow -M http-gangliagmetad-port
[root@netrunner audit]# semodule -i http-gangliagmetad-port.pp
```

After this everything should work like a charm. To confirm that We have
this new policy working:

``` {.toolbar:1 .striped:false .marking:false .ranges:false .nums:false .nums-toggle:false .wrap:true .lang:default .decode:true}
[root@netrunner modules]# semodule -l | grep ganglia
http-gangliagmetad-port 1.0
```

<!--:--><!--:pl-->[![SELinux](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/09/post-38-pinguim-do-selinux.jpg){width="200"
height="181"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/09/post-38-pinguim-do-selinux.jpg)While
setting up test server with Ganglia triad (gmetad, gmond, gweb over
Apache) I had only 2 SELinux alerts to solve. First one regarding to
denial of /var/lib/ganglia/rrd access by httpd process (while accessing
ganglia-web interface):

    type=AVC msg=audit(1380480812.081:1792): avc:  denied  { setattr } for  pid=5876 comm="rrdtool" name="fontconfig" dev=dm-1 ino=47054911 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=system_u:object_r:fonts_cache_t:s0 tclass=dir

In order to resolve that I just added SELinux contexts to rrdtool binary
and /var/lib/ganglia/rrds dir:

    chcon -t httpd_sys_script_exec_t /usr/bin/rrdtool
    chcon -t httpd_sys_content_t /var/lib/ganglia/rrds -R

The last SELinux alert was regarding to Apache trying to access port
8652 by socket connection (on ganglia-web I saw error like "fsockopen
8652 access denied"):

    type=AVC msg=audit(1380480626.847:1764): avc:  denied  { name_connect } for  pid=2016 comm="httpd" dest=8652 scontext=unconfined_u:system_r:httpd_t:s0 tcontext=system_u:object_r:port_t:s0 tclass=tcp_socket

So I had to create local policy for this particular occasion as there is
no ganglia modules for SELinux (maybe I should create one...?). Firstly
let's check that there's no even one module:

    [root@netrunner audit]# semodule -l | egrep -i "(ganglia|gmond|gmetad|gweb)" | wc -l
    0

So let's create this policy:

    [root@netrunner audit]# grep httpd /var/log/audit/audit.log | audit2allow -M http-gangliagmetad-port
    [root@netrunner audit]# semodule -i http-gangliagmetad-port.pp

After this everything should work like a charm. To confirm that We have
this new policy working:

``` {.crayon-selected}
[root@netrunner modules]# semodule -l | grep ganglia
http-gangliagmetad-port 1.0
```

<!--:-->
