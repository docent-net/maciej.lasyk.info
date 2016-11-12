Title: Automating Pelican with Git
Date: 2014-08-19 00:35
Category: pelican
Tags: pelican,git
Author: Maciej Lasyk
Summary: How to automate publishing Pelican posts with Git

<center>![Pelican Automation with Git]({filename}/images/pelican-automation.png)</center>

This is a first blogpost of a whole series about working with
[Pelican](http://docs.getpelican.com/). I'll be publishing all future post with
the hashtag [#pelican]({tag}/pelican}).

### What kind of automation? ###

My first step with migrating my [old blog](http://maciek.lasyk.info/sysop) to
this **Pelican - based** was to automate the whole process of deploying new
posts. I just want to work with **Markdown** files on my laptop and push those
to the git repository. And let the rest magically happen in the background.

### Architecture ###

Basically I write posts on my laptop, then I push changes to the remote bare
git repo, this repo has **post-update** hook which communicates with my
webserver and tells him to pull all the changes:

    :::bash
    laptop with markdowns ----(git push)----> remote git bare repo 
    ----(post-update hook----> webserver

### Abracadabra ###

What's important here - I've added to the repo my whole **pelican**
directory. This is because I'm realy lazy and just wanted to keep all the 
changes and use this repo also for backup purposes. Of course you'll want to
play with **.gitignore** file and ommit couple of dirs and files :)

On the server with git bare repo I've created **hooks/post-update** file
(perms 0700) with following contents:

    :::bash
    #!/bin/sh

    # just invoke the update script on the webserver:
    ssh home-docker '/home/docent/scripts/update_maciej.lasyk.info.sh'

As you can see I'm using here **ssh home-docker** command. This is an alias
that exists in my **~/.ssh/config**:

    :::bash
    Host home-docker
    Hostname vm-9-containers.netrunner.lasyk.info
    User docent
    Port 22
    ProxyCommand ssh -p 55555 docent@netrunner.lasyk.info nc %h %p 2> /dev/null
    IdentityFile ~/.ssh/id_rsa

This basically connects to VM hosting Docker containers through the bastion
server (no direct SSH allowed to containers VM from outside or DMZ).

So now anytime I post something and commit it to the repo above script will be
invoked via SSH. And this calls another script - this time on webserver:

    :::bash
    #!/bin/bash
    GIT=/usr/bin/git

    cd /srv/docker_mounts/nginx/public_html/maciej.lasyk.info/
    $GIT fetch --all
    $GIT reset --hard docent/master

Above script fetches all data from the remote repository and then sets the
last commit as the HEAD. No webserver restart is needed here as those are only
static files :)
