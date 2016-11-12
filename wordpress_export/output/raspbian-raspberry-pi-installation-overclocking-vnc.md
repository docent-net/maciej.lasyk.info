Title: Raspbian, Raspberry-PI, installation, overclocking && vnc
Date: 2013-05-17 09:05
Author: docent
Category: Uncategorized
Tags: overclocking, raspberry-pi, raspbian, rpi, vnc
Slug: raspbian-raspberry-pi-installation-overclocking-vnc
Status: published

<!--:en-->[![Raspberry-PI](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/05/2013-05-17-11.53.34-300x225.jpg){.aligncenter
.size-medium .wp-image-294 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/05/2013-05-17-11.53.34.jpg)

During last hackathon in [Ganymede](http://www.ganymede.eu) I created a
working instance of monitoring system which included Nagios, Jira,
Ganglia and hardware like Raspberry-PI and Arduino (those ARMs are used
just for end-user purposes like dashboards and alert lights).

For now I'd like to make a quick write up of preparing Raspbian to work
on R-PI. Those are easy things, but it's good to have them in a note.

1.  <span style="line-height: 13px;">Installing Raspberry-PI from Linux
    box (firstly download Raspbian img
    from <http://www.raspberrypi.org/downloads>)</span>
    -   Format Your SD card in FAT32:

        ``` {.lang:sh .decode:true}
        root@rpi2:~# mkdosfs -F 32 -v /dev/mmcblk0
        ```

    -   Copy img file to SD using dd:

        ``` {.lang:default .decode:true}
        root@rpi2:~# dd bs=1M if="2013-02-09-wheezy-raspbian.img" of=/dev/mmcblk0
        ```

2.  Overclocking (gives us a good boost needed for displaying
    complicated dashboards - You can read about overclocking here:
    <http://www.raspberrypi.org/archives/tag/overclocking>):
    -   Mount SD card somewhere in the linux box and edit
        the **config.txt** file from this Raspbian boot-partition so it
        looks like:

            over_voltage=6
            arm_freq=1000
            core_freq=500
            sdram_freq=500

3.   VNC installation on display 0: (so You can VNC into the main
    display / desktop):
    -   VNC installation:

            root@rpi2:~# apt-get install x11vnc
            root@rpi2:~# x11vnc -storepasswd /etc/x11vnc.pass

    -   Now the init script (save it as **/etc/init.d/vnc**):

            /usr/bin/x11vnc -xkb -auth /var/run/lightdm/root/:0 -noxrecord -noxfixes -noxdamage -rfbauth /etc/x11vnc.pass -forever -bg -rfbport 5900 -o /var/log/x11vnc.log

    -   And just make it start during the boot process:

            root@rpi2:~# chmod +x /etc/init.d/vnc
            root@rpi2:~# update-rc.d vnc defaults

4.  Prevent screen from turning off:
    -   Edit **/etc/kbd/config** so it contains following entries:

        ``` {.lang:default .decode:true}
        BLANK_TIME=0
        POWERDOWN_TIME=0
        ```

        <p>
        and restart kbd:** /etc/init.d/kbd restart**

    -   Edit vim /etc/lightdm/lightdm.conf so it contains following
        entry in the section \[SeatDefaults\]:

        ``` {.lang:default .decode:true}
        xserver-command=X -s 0 dpms
        ```

That's all for now. I'll try to make a blog-post about that hackathon
project as I've been receiving questions about it. It's possible, that
I'll try to make a talk about it during the next OWASP meeting here at
our Kraków / Poland
chapter.<!--:--><!--:pl-->[![Raspberry-PI](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/05/2013-05-17-11.53.34-300x225.jpg){.aligncenter
.size-medium .wp-image-294 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/05/2013-05-17-11.53.34.jpg)

During last hackathon in [Ganymede](http://www.ganymede.eu) I created a
working instance of monitoring system which included Nagios, Jira,
Ganglia and hardware like Raspberry-PI and Arduino (those ARMs are used
just for end-user purposes like dashboards and alert lights).

For now I'd like to make a quick write up of preparing Raspbian to work
on R-PI. Those are easy things, but it's good to have them in a note.

1.  <span style="line-height: 13px;">Installing Raspberry-PI from Linux
    box (firstly download Raspbian img
    from <http://www.raspberrypi.org/downloads>)</span>
    -   Format Your SD card in FAT32:

        ``` {.lang:sh .decode:true}
        root@rpi2:~# mkdosfs -F 32 -v /dev/mmcblk0
        ```

    -   Copy img file to SD using dd:

        ``` {.lang:default .decode:true}
        root@rpi2:~# dd bs=1M if="2013-02-09-wheezy-raspbian.img" of=/dev/mmcblk0
        ```

2.  Overclocking (gives us a good boost needed for displaying
    complicated dashboards - You can read about overclocking here:
    <http://www.raspberrypi.org/archives/tag/overclocking>):
    -   Mount SD card somewhere in the linux box and edit
        the **config.txt** file from this Raspbian boot-partition so it
        looks like:

            over_voltage=6
            arm_freq=1000
            core_freq=500
            sdram_freq=500

3.   VNC installation on display 0: (so You can VNC into the main
    display / desktop):
    -   VNC installation:

            root@rpi2:~# apt-get install x11vnc
            root@rpi2:~# x11vnc -storepasswd /etc/x11vnc.pass

    -   Now the init script (save it as **/etc/init.d/vnc**):

            /usr/bin/x11vnc -xkb -auth /var/run/lightdm/root/:0 -noxrecord -noxfixes -noxdamage -rfbauth /etc/x11vnc.pass -forever -bg -rfbport 5900 -o /var/log/x11vnc.log

    -   And just make it start during the boot process:

            root@rpi2:~# chmod +x /etc/init.d/vnc
            root@rpi2:~# update-rc.d vnc defaults

4.  Prevent screen from turning off:
    -   Edit **/etc/kbd/config** so it contains following entries:

        ``` {.lang:default .decode:true}
        BLANK_TIME=0
        POWERDOWN_TIME=0
        ```

        <p>
        and restart kbd:** /etc/init.d/kbd restart**

    -   Edit vim /etc/lightdm/lightdm.conf so it contains following
        entry in the section \[SeatDefaults\]:

        ``` {.lang:default .decode:true}
        xserver-command=X -s 0 dpms
        ```

That's all for now. I'll try to make a blog-post about that hackathon
project as I've been receiving questions about it. It's possible, that
I'll try to make a talk about it during the next OWASP meeting here at
our Kraków / Poland chapter.<!--:-->
