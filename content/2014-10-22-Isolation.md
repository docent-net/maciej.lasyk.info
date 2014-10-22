Title: Isolation
Category: tech
Tags: containers,lxc,docker,kvm,virtualization,security
Author: Maciej Lasyk
Summary: Why we should isolate Linux containers

# Isolation - what? #

Many of guys I talk to tend to run their Linux containers (LXC, Docker, you
name it) straight on bare. And I call this a bad idea. This is because when
running all the containers within one single box you will be hit by network or
security problems. Not today, but it will happen. Why?

# Clusterfuck network #

This term is used to describe a network where noone knows what's happening.
Frankly it's working but don't-try-to-change-that (unless you're stupid  brave
/ enough).

<center>![Clusterfuck network]({filename}/images/clusterfucknetwork.jpg)</center>

How does it refers to containers? Imagine that above wires are iptables rules.
Should I write more? What happens when you restart iptables? Did you just
killed the network in 300 containers running on that box? Oh whatever iptables
- think docker0 interface + bonding/teaming + multiple bridges + veths + VIPs +
vlans + whatever-your-sysadmins-come-with

And now one single junior - sysadmin just reloads iptables as was written in
the 5th point of never-updated-procedure.

That's why I really like to have containers grouped on KVM VMs. KVM overhead is
minimal these years. And it can save your ass. Just make a proper Ha planning
and even if you kill some group of containers you will not have to firefight
having 5 managers simultaneously on 3 calls ;)

# Security #

Yes I know - this term is usually some big-fucking-unknown for most of guys /
ignorants. And that is why you should isolate groups of containers from each other. Throw
the first rock who uses SELinux / enforcing (under these circumstances you
could possibly cover the security subject in the terms on containers). But even
if you do then see > **Clusterfuck network** paragraph).

Btw - I had this talk during Infosec meetup some time ago about Docker
security - [enjoy](http://www.slideshare.net/d0cent/docker-rhel)!

# What about IaaSes? #

Yes - if you're running [OpenShift]https://openshift.github.io/) (or any other
Open:Nebula/Stack/Whatever) then probably you will not care about isolation at
all because this will be done for you without your interference. But -
seriously? Usually people rather use VMs for hosting nodes of IaaSes.

# Recap? #

No. Just wrote this after having a failure with LXC containers on Centos7 and
no-real-explanation just "have-you-tried-to-turn-it-iff-and-on-again?".

<center>![Isolation]({filename}/images/isolation.jpg)</center>
