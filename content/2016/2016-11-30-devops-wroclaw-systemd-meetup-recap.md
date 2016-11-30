Title: Wrocław devops meetup recap
Category: tech
Tags: systemd, learning-series, learning-systemd, meetup
Author: Maciej Lasyk
Summary: a few words about my last talk

<center>![systemd devops meetup at Wrocław!]({filename}/images/wroclaw-devops-systemd.jpg)</center>

# How did it go? #

Well, I must admit that yet again it didn't go without unpredicted and stressful
moments. I run [systemd workshops]({filename}/2016/2016-11-27-systemd-workshops-recap.md)
last weekend so I was rather fresh in terms of content knowledge. The only 
thing left was preparing slides and making sure all demos work offline.

So I did. And about 2 hours before meetup beginning I realized, that demos are not 
working because of some bad imports in Python code. It was a mess - even demos
from workshops didn't work. I asked my self WTF couple of times, but somehow
found, that this was because of **dnf upgrade** and some more global
**pip installs** related to systemd libs that I made 2 evenings before and even 
forgot about it (yep, I work mainly on virtualenvs, but for some reason - not 
this time). I'm working on a blog post explaining the winding road to
systemd/Python development (the hard part is about 4 different libraries being
there). I'll publish it within next few days.

So the feedback was really positive - thanks! Quite many people approached me
after presentation and told, that they learned much and would like to see more 
(e.g. during workshops). That was really nice - feedback always appreciated :)

Btw - I told some of you about discussion on debian.org about systemd 
integration. So [here it is](https://wiki.debian.org/Debate/initsystem/systemd)
- very good reading. Srsly.

# What did I learn? #

1. That even Debian / Ubuntu centric people are really keen to learn how 
   systemd might help them. E.g. **KillMode**, journal fields, boot process
   analyzing, sd-notify Python bindings, dbus - communication & busctl 
   pcap/Wireshark export, handy nspawn containers and so many more.
1. That Python systemd libraries overlaps with each other. Not that big mess, 
   but I really have to sort it out and post about it and ask authors about
   those overlappings.
1. That systemd hate is actually gone when you talk about details, listen to
   people problems (and really guys - listen and understand) and explain
   thoroughly. There's no hate when you treat others equally.
1. That reading couple of times [The Biggest Myths](http://0pointer.de/blog/projects/the-biggest-myths.html)
   about systemd by Lennart Poettering helped me much in terms of
   talking to people and explaining them why systemd is created this way and
   not other (thanks Lennart!)
1. That systemd conference in Berlin I attended 2 times in a row was a great
   idea and that I will get there again and again. If you missed it - you
   may [watch the videos](https://www.youtube.com/channel/UCvq_RgZp3kljp9X8Io9Z1DA/videos)
   
# Slides & materials #

I published slides [here](http://maciej.lasyk.info/slides/wroclaw_devops_systemd_2016/)
(not sure why it doesn't work on FF for me, try w/Chrome).

Codebase is on [systemd workshops repo](https://github.com/docent-net/systemd-workshop)

# Thank you guys! #

Thanks to organizers (Kasia Wojciechowska, Kamil Herbik & Tomek Tarczyński).
Great job with preparations - I love your underground - pub venue!

Thanks to Piotrek Kurpik from Ocado Technology for his great support. It's
always nice to have your guy on the side ;)

And many, many thanks to all attendees - for your presence, questions, 
feedback and help during presentation when it was needed ;)

## Anything more? #learningsystemd! ##

If you wanna learn more about **systemd** simply follow 
[learning-systemd RSS](/feeds/tag/learning-systemd.rss.xml)
or
[learning-systemd ATOM](/feeds/tag/learning-systemd.atom.xml)
tag in this very blog (or on Twitter:
[#learningsystemd](https://twitter.com/search?f=tweets&q=%23learningsystemd&src=typd))