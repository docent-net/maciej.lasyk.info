Title: Wacom Bamboo Fun in Fedora 15
Date: 2012-01-11 20:44
Author: docent
Category: tech
Tags: fedora, fedoraplanet, tablet, wacom, x
Slug: wacom-bamboo-fun-in-fedora-15
Status: published

<!--:en-->Today I connected my wife's Wacom Bamboo Fun CTH-461 to my
desktop with Fedora 15 on the 2.6.41.4-1.fc15.x86\_64 kernel. It worked
like a charm - just plug&play - that's because I already got installed X
drivers for the Wacom:

    [docent@docent-desktop ~]$ rpm -qa | grep -i wacom xorg-x11-drv-wacom-0.11.1-3.fc15.x86_64

If You have issues with Wacom under Fedora 15 - just try to install
above drivers and reboot X.

But I really hate this multi - touch when I'd like to draw something
with the pen, so I wanted to turn it off. Also I wanted the pen to work
only on the first monitor - not on the both (I use dual monitors with
extended desktops). We can set all those things with **xwacomset**
command. First We have to know our Wacom devices:

    [docent@docent-desktop ~]$ xsetwacom list dev Wacom Bamboo Craft Finger touch id: 11 type: TOUCH Wacom Bamboo Craft Finger pad id: 12 type: PAD Wacom Bamboo Craft Pen stylus id: 13 type: STYLUS Wacom Bamboo Craft Pen eraser id: 14 type: ERASER

Now when We have those devices' names We can turn off the multi touch:

    [docent@docent-desktop ~]$ xsetwacom set 'Wacom Bamboo Craft Finger touch' touch off

When done with multi touch We can set the working space of our tablet to
the first display unit. Firsly we have to know current mapping settings:

    [docent@docent-desktop ~]$ xsetwacom get "Wacom Bamboo Craft Pen stylus" Area 0 0 14720 9200 

Now If You want to map the pen to the left monitor, just double the
third number:

    xsetwacom set "Wacom Bamboo Craft Pen stylus" Area "0 0 29440 9200"

Now I had all done and were ready to go with my work :)<!--:-->
