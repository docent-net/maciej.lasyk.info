Title: Working on blog
Category: tech
Tags: blog, pelican
Author: Maciej Lasyk
Summary: Boring entry about changes on this blog

<center>![boring]({filename}/images/boring.jpg)</center>

## Changes (again?...) ##

Yes, number of "todos" in my Workflowy list according to this blog reached a
level, when I just have to start working on it. There're many things:

1. Fix layout:
  1, It has to work fine on mobile as well as on 27"
  1. It has to be nice, readable instead of contrasting and heavy
  1. It has to load very fast (under 100ms)
  1. No cumbersome clicking
1. Finally host with SSL
1. Add URLs for Github, Twitter, StackOverflow etc (contact page)
1. Create 3 main categories (tech, sport, random) with RSS per each (and one 
   global)
1. Add tag + section of my books library (all categories)
1. Import posts from http://maciek.lasyk.info, close old page and 301 it!

What I actually done already?

1. Fix fonts
1. Fix not showing tags after Pelican upgrade
1. Fix deployment model (own bare repo w/post-receive hook deploying to prod +
   repo mirror on github)
   
So now actually you may find this blog's whole source [on github](https://github.com/docent-net/maciej.lasyk.info)!
Not a big deal, but maybe for some of you it's gonna be interesting.

Also I started working on importer script that will import old Wordpress 
entries to this blog (see on [Github](maciej.lasyk.info/wordpress_export/import.py)
