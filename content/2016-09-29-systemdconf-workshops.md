Title: systemdconf(2): 1st day / workshop summary
Category: tech
Tags: systemd, conference, conf, berlin
Author: Maciej Lasyk
Summary: Summary from 1st day of systemdconf 2016 

<center>![PID1]({filename}/images/pid1.png)</center>

## systemdconf(2) ##

So it's the second time **systemdconf** takes place. Again - in Berlin, which I find even more pretty in early Autumn 
than year before (which was in November) - sunny and warm.

Full schedule of this year's edition is [here](https://cfp.systemd.io/en/systemdconf_2016/public/schedule/0). Last year 
there was no workshops, but there was a hackfest on the last day. This time we have a workshop on the 0 - day (I call
it "0 - day" as this is an optional and needs an additional ticket).

So first 2 sessions were common for all attendees:

- **Demystifying systemd - Hands On** by **Ben Breard**
- **Using the Journal Efficiently** by **Lennart Poettering**

Afterwards I found it very hard to choose between next sessions that were taking place in same time. I really wanted
to take part in **Lukáš Nykrýn's** workshop about **systemd-nspawn 101** and learn about **mgmt** from **James Shubin**.
But I finally chose almost 5 - hour session about **Writing services the systemd way** lead by **David Strauss**.


## Session 1: Demystifying systemd - Hands on by Ben Breard ##

I was late almost 90 minutes as my coach bus was late almost 2 - hours (thanks to traffic jams on south entrance to 
Berlin). But I quickly synced to the rest of people thanks to [wonderful materials prepared by 
Ben](http://people.redhat.com/bbreard/systemd/DemystifyingsystemdHandsOn.html).

I decided to go through this workshop without using VMs but systemd-nspawn container instead. Thanks to this approach
I was able to create one container per workshop task in a quick and elegant way without wasting resources on KVM 
VMs or some other Vagrant abomination ;)

I found a little error in the materials for systemd-nspawn preparation. It should be:

```sudo dnf --releasever=24 --installroot=/var/lib/machine/f24 install systemd passwd dnf fedora-release```

Also I suggest creating this container under **/var/lib/machines** as this directory already has proper selinux type
(and we don't want to run with selinux disabled, yeah?)

Also I'd suggest installing following packages:

```dnf install systemd-devel telnet telnet-server procps pkg-config make automake gcc git vim-enhanced iproute```

And in the end - use this container as template for any following task from all the workshop sessions:

```cp -R /var/lib/machines/f24 /var/lib/machines/f24-workshop1```

I've published notes from this session on [my github](https://github.com/docent-net/systemd-conference-2016)

Generally speaking I'm very glad to attend this session - it was a wholesome recap of systemd basics!

## Session 2: Using the Journal Efficiently by Lennart Poettering ##

This session was run by Lennart. If I were asked **how to describe it in one sentence** it would be: **man systemctl
with Lennart's incredible comment and things that can't be find in man**. I really loved it. And as usual - Lennart
explained the matter of logging w/journald so extensively that actually it was hard to even ask about anything.

Beside **man systemctl** things Lennart talked in details about unit's metadata (see **-o verbose** and all those 
uppercase params), cursors and gatewayd.

I've published notes from this session on [my github](https://github.com/docent-net/systemd-conference-2016)

Again - outstanding session.

## Session 3: Writing services the systemd way by David Strauss ##

During this session we created a simple C application which later we converted into a systemd service with some
basic systemd functionalities:

- journald integration via sd_journal
- monitoring / watchdog via sd_notify
- socket activation 

Whole session was packed with coding, compiling, re - compiling and trying. It was very intensive, fast - paced and...
great! Afterwards we also saw corresponding [python-systemd](https://github.com/systemd/python-systemd) wrappers.
Actually one of my ideas for Saturday hackfest is to rewrite this session's subject in Python in order to learn
how Python integration works.

Again - totally awesome session!

Materials for this session are hosted on [Github](https://github.com/systemd/tutorials/tree/berlin). Simply start 
with **starter** directory and apply logdaemon, watchdogdaemon and sadaemon on that starter content.

I didn't make notes during this session - there was no time, only coding and compiling.

## systemd-nspawn 101 by Lukáš Nykrýn ##

Unfortunately I didn't attend this workshops. However I asked Lukáš about materials - 
[he already published his slides](http://redhat.slides.com/lnykryn/systemd-nspawn-101#)

## Next Generation Config Mgmt: Workshop by James (purpleidea) Shubin ##

And now for something completely different ;) Also - I couldn't attend this one, but I caught up day after with James
and asked about materials. However there're no dedicated materials from that workshops, you can basically hack around
mgmt basing on [github project page](https://github.com/purpleidea/mgmt/). This is very interesting project which needs
contributions (GoLang here) so if you're interested - go for it!

## So that's it ##

Basically that's it. I have to say that I really like the idea of workshops and this day was 100% worth its price. I
was able to recap my systemd knowledge, update it, ask questions to people who actually develop systemd and understand
concepts which were not tha easy for me. Also I already have some implementations ideas that were born during those
workshops so - thank you guys!
