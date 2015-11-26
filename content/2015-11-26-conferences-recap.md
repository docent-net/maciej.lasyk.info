Title: Autumn conferences recap
Category: tech
Tags: conference,devops,devopsdays,pycon,systemd
Author: Maciej Lasyk
Summary: A short recap from the Pycon.cz, systemd.conf and Devopsdays Warsaw 2015 conferences

I do like taking part in conferences. I still think, that conferences are one of the most important places where people
get motivated (e.g. by meeting influencers, talking to other engineers, listening to completely new ideas or having
opportunity to ask).

Also I'm certain that thanks to conferences we improve ourselves. We improve our communication & soft skills, we learn
to ask proper questions or polish our engineering skills during deep technical discussions. And also we actually have
the opportunity to show others our achievements during ignite talks.

Also I really do love travelling to new places. My private motivation behind this is always the same - to have even a 
while for a short run in a new place; just like this:

<center>![Lazienki]({filename}/images/lazienki.jpg)</center>

Last but not least. Always try to commute using some public bicycle rentals. Thanks to that we have this unique 
opportunity to actually see the those interesting parts of cities.

## systemd.event ##

<center>![systemd]({filename}/images/systemd-event-2015-lennart.jpg)</center>

This was the first edition of **systemd** conference. It took place in Berlin, place where 
[Lennart Poettering](https://en.wikipedia.org/wiki/Lennart_Poettering) lies in his cave ;)

I really looked forward this event, so many props for [Marcin Skarbek](https://en.wikipedia.org/wiki/Lennart_Poettering)
for the idea of travelling to Berlin.

What I liked about the event?

- **agenda** - basically most of presentations were deeply, technical about systemd; bullshit factor: 1/10 - that's a 
great score!
- **hackfest** - during 3rd day we took part in a hackfest. we wrote down some ideas and worked on those. My idea was
not that strictly connected to systemd; I just wanted to run some service (GoCD) on different containerization engines
so I'd be able to compare those and make my own opinion. I've put everything I did there on 
[github](https://github.com/docent-net/systemd-conference-2015-hacking) - not that much as I was struggling with
some Docker/FS issue for a majority of time (generally speaking **docker-storage-setup** is an abomination)
- **venue** - conference was placed in a co-working place with 7/10 hipster factor ;) The room was not that huge - but
there were no problems with crowd or whatever - there was plenty of space
- **city** - I've been to Berlin for the first time and I must say - I liked it! 
[I've put some photos in G+](https://plus.google.com/+MaciejLasykDocent/posts/LsgcAWfeR4H)

**Which talks I liked the most?**

- [Fedora Chicanery: How to use systemd nonsense hacks to solve real problems](https://www.youtube.com/watch?v=9Sq6FgOW6p8) 
by [Stephen Gallagher](https://twitter.com/sgallagh_redhat)
- [journald and the new options for remote logging](https://www.youtube.com/watch?v=eqr_rtlNY_Y) by 
Zbigniew Jędrzejewski-Szmek
- [Making Docker and systemd play nice together](https://www.youtube.com/watch?v=zVy1lQqJJj8) by [Dan Walsh](https://twitter.com/rhatdan)
- [Challenges Deploying Over 5,000 Containers per Host](https://www.youtube.com/watch?v=wVk-NWtiIZY) by 
[David Strauss](https://twitter.com/DavidStrauss)
- [systemd and Control Groups](https://www.youtube.com/watch?v=7CWmuhkgZWs) by Lennart Poettering

The official webpage of conference is here: [https://systemd.events/](https://systemd.events/). You can also watch
all the [videos here on youtube channel](https://www.youtube.com/channel/UCvq_RgZp3kljp9X8Io9Z1DA).

Of course remember to [check the official systemd page](https://wiki.freedesktop.org/www/Software/systemd/)

## pycon.cz ##

<center>![pycon]({filename}/images/pycon-cz-logo.png)</center>

Actually this was first conference where I saw serving vodka with Redbulls (starting from.. 11a.m.?). Incredible :D

About the conference - this was my first Python conference, and just like with the systemd.event I really liked the idea
of one day of talks and second day of workshops and sprints.

Also just couldn't resist and not take a photo on the Fedora booth ;)

<center>![fedorabooth]({filename}/images/pycon-cz-fedora.jpg)</center>

**About presentations I liked:**

- [The future of Twisted](https://speakerdeck.com/hawkowl/the-future-of-twisted-and-pretty-much-everything-else-pycon-cz-keynote-2015)
 by [Amber Brown](https://twitter.com/hawkieowl)
- **So you have an Python app and now what?** by [Věroš Kaplan](https://twitter.com/verosk)

On the second day there were workshops / sprint sessions. I took part in webscraping workshop and GIS. Everything I
worked on during those events is now placed [on my github account](https://github.com/docent-net/pyconcz-2015-hacking)

I personally traveled those 300km mainly to take part in workshops and I must say that i really liked it! I found it
very helpful and well organized. Also the workshop venue was great - yet another co-working space with hipster factor 
8/10 (even more than in Berlin in systemd.conf!)

Many thanks to organizers - keep it this way guys!

## Devopsdays Warsaw 2015 ##

<center>![Devopsdays]({filename}/images/devopsdays-warsaw-logo.png)</center>

This year was a second edition of **Devopsdays** here in Poland. We hosted many great 
[presenters]( http://2015.devopsdays.pl/agenda/speakers/) and audience.

This time I was asked to be part of the Program Committee (thanks for that guys!), so I had this unique opportunity
to actually have an impact on the agenda of this event. We all did our best to make sure that this would be an awesome
conference :)

Actually there were many good ideas (Ignite Talks and Open Spaces were the most interesting imo).

**Which presentation I liked the most?**

- [The dark art of container monitoring](http://2015.devopsdays.pl/agenda/talk/the-dark-art-of-container-monitoring/) by
[Luca Marturana](https://twitter.com/luca3m). It's about tool that should be already well known by systems engineers - it
 is called [Sysdig](https://sysdig.com/) and it rocks in terms of OS excavations. 
- [The hidden cost of the microservices architecture](http://2015.devopsdays.pl/agenda/talk/hidden-cost-microservices-architecture/)
by [Mirosław Nagaś](https://twitter.com/miroslawnagas). Mirek told a story of impelmenting Microservices in [Base](https://lab.getbase.com/)
company. This was a classical case-study, which are so needed on conferences. I really appreciate when people share
their experiences - many props for that Mirek!
- [Jenkins as a Code](http://2015.devopsdays.pl/agenda/talk/jaac-jenkins-as-a-code/) by 
[Łukasz Szczęsny](https://twitter.com/wybczu). Łukasz showed us, how to approach Jenkins in an automated way forgetting
non-fancy UI, hell of configuration-clickin' and maintaining dependencies between jobs. And he actually used Ansible - 
so many props ;)

**Ignite talks**

<center>![Devopsdays Openspaces]({filename}/images/devopsdays-openspaces.jpg)</center>

This was a great and simple idea: people write down subjects to discuss, then all of us vote for the most interesting
topics and finally we start discussions.

My favorite ones:

- **life and work balance** - it was about understanding how we get the idea of work-life balance and where're limits
- **Continuous Delivery - success stories** - self explaining ;)
- **Hard vs Soft skills** - oh seriously we discussed everything that was not technical-related
- **Moving to systemd** - we tried to answer questions about systemd
