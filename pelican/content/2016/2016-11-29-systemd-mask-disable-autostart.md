Title: systemd mask
Category: tech
Tags: systemd, mask, learning-series, learning-systemd, systemctl
Author: Maciej Lasyk
Summary: how to prevent service from being started upon installation?

<center>![PID1 for the win!]({filename}/images/pid1.png)</center>

## Problem ##

I come from Slackware and later RHEL / Fedora world. For me it's natural that
whenever I install any service it's not started until I say so.

So I was bit scarred, when long time ago on some Debian / Ubuntu I realized,
that after installing HTTPD server it started immediately. I didn't know until
it was registered within our HaProxy load - balancer starting servicing some
default content instead of it should be in case it was properly configured. 

So it was really peculiar back then, that service may be started without any
confirmation even before it it properly configured!

## Looking for solution before systemd ##

So I started digging and looking for an straightforward answer how to disable
"auto - starting upon installation". And I didn't find nothing really useful
beside some hacks.

However after digging even deeper I [found this](https://anonscm.debian.org/git/collab-maint/init-system-helpers.git/tree/script/deb-systemd-invoke#n70)
- so looks like that starting from Ubuntu 16.04 there is a native method
implemented in **policy-rc.d**:

```bash
if (-x $policyhelper) {
    for my $unit (@units) {
        system(qq|$policyhelper $unit "$action"|);

        # 0 or 104 means run
        # 101 means do not run
        my $exitcode = ($? >> 8);
        if ($exitcode == 101) {
            print STDERR "$policyhelper returned 101, not running '" . join(' ', @ARGV) . "'\n";
            exit 0;
        } elsif ($exitcode != 104 && $exitcode != 0) {
            print STDERR "deb-systemd-invoke only supports $policyhelper return codes 0, 101, and 104!\n";
            print STDERR "Got return code $exitcode, ignoring.\n";
        }
    }
}
```

So actually what's enough is:

```bash
sudo echo -e '#!/bin/bash\nexit 101' > /usr/sbin/policy-rc.d
sudo chmod 755 /usr/sbin/policy-rc.d
sudo /usr/sbin/policy-rc.d
```

After doing so **no service will be started upon installation**. So it's a 
global change.

## how about systemd? ##

So systemd provides **mask** method within **systemctl**. From the 
documentation:

       mask NAME...
           Mask one or more units, as specified on the command line. This will link
           these unit files to /dev/null, making it impossible to start them. This
           is a stronger version of disable, since it prohibits all kinds of
           activation of the unit, including enablement and manual activation. Use
           this option with care. This honors the --runtime option to only mask
           temporarily until the next reboot of the system. The --now option may be
           used to ensure that the units are also stopped. This command expects
           valid unit names only, it does not accept unit file paths.

       unmask NAME...
           Unmask one or more unit files, as specified on the command line. This
           will undo the effect of mask. This command expects valid unit names
           only, it does not accept unit file paths.

So basically we may tell systemd to make sure that even if service is enabled
or started manually it will refuse to do so.

But how that solves problem of auto - starting upon installation? Before we
**apt-get/dnf/yum install** we may mask service we want to install by creating
symlink:

```bash
 ln -s /dev/null /etc/systemd/system/apache2.service
```

This way Apache will not be started after installation. 

## Vendor policy and default presets ##

systemd also provides packages vendors with possibility to define if 
application should or should not be started upon installation. It's a very
good win - win solution, as now maintainer may actually decide.

If you want to see how service behaves after installation simply:

```bash
[root@fedex system]# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
```

Take not of **vendor preset: disabled** above. It tells us that auto - starting
upon installation is disabled for this package.

systemd also provides a functionality to manage presets with **systemctl**:

       preset NAME...
           Reset the enable/disable status one or more unit files, as specified on the command line, to the defaults configured in the preset policy files. This has the
           same effect as disable or enable, depending how the unit is listed in the preset files.

           Use --preset-mode= to control whether units shall be enabled and disabled, or only enabled, or only disabled.

           If the unit carries no install information, it will be silently ignored by this command.  NAME must be the real unit name, any alias names are ignored
           silently.

           For more information on the preset policy format, see systemd.preset(5). For more information on the concept of presets, please consult the Preset[1]
           document.

       preset-all
           Resets all installed unit files to the defaults configured in the preset policy file (see above).

           Use --preset-mode= to control whether units shall be enabled and disabled, or only enabled, or only disabled

## Anything more? #learningsystemd! ##

If you wanna learn more about **systemd** simply follow 
[learning-systemd RSS](/feeds/tag/learning-systemd.rss.xml)
or
[learning-systemd ATOM](/feeds/tag/learning-systemd.atom.xml)
tag in this very blog (or on Twitter:
[#learningsystemd](https://twitter.com/search?f=tweets&q=%23learningsystemd&src=typd))