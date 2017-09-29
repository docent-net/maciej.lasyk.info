Title: Docker vs LXC/Ansible?
Date: 2014-03-16 19:46
Author: docent
Category: tech
Tags: ansible, docker, fedoraplanet, kvm, lxc, virtualization, xen, containers
Slug: docker-vs-lxcansible
Status: published

<!--:en-->

[![Containers](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/03/containers-300x248.png){.aligncenter
.wp-image-524 width="300"
height="248"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/03/containers.png)

Why this question?
------------------

During last DevOPS meetup
[@GrzegorzNosek](https://twitter.com/GrzegorzNosek) asked very good
question - why should one use Docker instead of pure LXC/Ansible?

Honestly I've been trying to answer myself this question for a while. I
did in some part (included this in my talk I gave during that
meetup: <http://www.slideshare.net/d0cent/docker-rhel>); while it's
about developers running development envs Docker is just so much easier
to use.

But how should I explain using Docker for myself? I'm sysadmin and I
love low-level - so LXC for me is just natural way of doing things :)

Your face, your ass - what's the difference?
--------------------------------------------

(If you feel embarassed / disgusted somehow with this header please
rewind 18 years and remember
that: <https://en.wikiquote.org/wiki/Duke_Nukem>)

One thing you should know about me - I'm contributing to FedoraProject;
lately I've been poking around Fedora-Dockerfiles project
(https://git.fedorahosted.org/cgit/dockerfiles.git/) - I'm doing it for
fun and also I wanted to learn more about Docker as I'm running some
Open-Source projects with friends and had to find a easy way for them to
rollup own development envs. Docker is the answer in this case.

So - currently I'm using Docker to prepare dev-envs for guys who knows
nothing about DevOPS / SysOPping; writing Dockerfiles is so much fun
(and sometimes so big hell :) ). And LXC? Together with Ansible I'm
managing some servers' resources (like VPN, DNS, some webservices etc).
It's also fun, it's fast, rather reliable and it makes things so much
easy to live with.

So any winners here?
--------------------

But still - for me as guy who use rather fdisk than gparted (or virsh
than virt-manager ;) ) Docker is not the case for managing services. And
honestly I'm still looking for an answer for the question from subject
of this blogpost. For now after couple of weeks poking around Docker
(and months with LXC) I can tell this one obvious thing that when You
know LXC than Docker is just so easy (e.g. running some daemons inside
spartan-like Docker images can be a tough fight whe some libs or
dependencies are missing). Also creating and running Dockerfiles is very
easy - just like creating Ansible playbooks.

I think that I'm gonna do this one thing that I did couple of years ago
when XEN and KVM were running shoulder to shoulder in the FOSS full-virt
race. I'm just gonna use them both - Docker and LXC and see how things
will develop. Docker is very great and easy to manage apps only (so
Continuous Development with Docker is killing feature) and I'll
LXC/Ansible within some basic services (GitLab, DNS, VPN etc). But for
more fun - I'm gonna keep both tracks, so e.g. when deploying GitLab
within LXC I'll create also Dockerfile for this.

This way I think that I will have a really good answer in just a couple
of weeks and this should be nice subject for some conference talk?

Follow my [GitHub account](https://github.com/docent-net) (or even
better - [Twitter](https://twitter.com/docent_net)) - I'll post there
updates about new playbooks and
Dockerfiles.<!--:--><!--:pl-->[![Containers](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/03/containers-300x248.png){.aligncenter
width="300"
height="248"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/03/containers.png)

Why this question?
------------------

During last DevOPS
meetup [@GrzegorzNosek](https://twitter.com/GrzegorzNosek) asked very
good question - why should one use Docker instead of pure LXC/Ansible?

Honestly I've been trying to answer myself this question for a while. I
did in some part (included this in my talk I gave during that
meetup: <http://www.slideshare.net/d0cent/docker-rhel>); while it's
about developers running development envs Docker is just so much easier
to use.

But how should I explain using Docker for myself? I'm sysadmin and I
love low-level - so LXC for me is just natural way of doing things :)

Your face, your ass - what's the difference?
--------------------------------------------

(If you feel embarassed / disgusted somehow with this header please
rewind 18 years and remember
that: <https://en.wikiquote.org/wiki/Duke_Nukem>)

One thing you should know about me - I'm contributing to FedoraProject;
lately I've been poking around Fedora-Dockerfiles project
(https://git.fedorahosted.org/cgit/dockerfiles.git/) - I'm doing it for
fun and also I wanted to learn more about Docker as I'm running some
Open-Source projects with friends and had to find a easy way for them to
rollup own development envs. Docker is the answer in this case.

So - currently I'm using Docker to prepare dev-envs for guys who knows
nothing about DevOPS / SysOPping; writing Dockerfiles is so much fun
(and sometimes so big hell :) ). And LXC? Together with Ansible I'm
managing some servers' resources (like VPN, DNS, some webservices etc).
It's also fun, it's fast, rather reliable and it makes things so much
easy to live with.

So any winners here?
--------------------

But still - for me as guy who use rather fdisk than gparted (or virsh
than virt-manager ;) ) Docker is not the case for managing services. And
honestly I'm still looking for an answer for the question from subject
of this blogpost. For now after couple of weeks poking around Docker
(and months with LXC) I can tell this one obvious thing that when You
know LXC than Docker is just so easy (e.g. running some daemons inside
spartan-like Docker images can be a tough fight whe some libs or
dependencies are missing). Also creating and running Dockerfiles is very
easy - just like creating Ansible playbooks.

I think that I'm gonna do this one thing that I did couple of years ago
when XEN and KVM were running shoulder to shoulder in the FOSS full-virt
race. I'm just gonna use them both - Docker and LXC and see how things
will develop. Docker is very great and easy to manage apps only (so
Continuous Development with Docker is killing feature) and I'll
LXC/Ansible within some basic services (GitLab, DNS, VPN etc). But for
more fun - I'm gonna keep both tracks, so e.g. when deploying GitLab
within LXC I'll create also Dockerfile for this.

This way I think that I will have a really good answer in just a couple
of weeks and this should be nice subject for some conference talk?

Follow my [GitHub account](https://github.com/docent-net) (or even
better - [Twitter](https://twitter.com/docent_net)) - I'll post there
updates about new playbooks and Dockerfiles.<!--:-->
