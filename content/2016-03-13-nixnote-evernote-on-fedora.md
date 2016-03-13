Title: Nixnote (Evernote client) on Fedora
Category: tech
Tags: evernote, nixnote
Author: Maciej Lasyk
Summary: Finally some decent Evernote client on Linux!

<center>![Evernote]({filename}/images/evernote_logo.png)</center>

I've been using [Evernote](http://www.evernote.com) for years now (Grzegorz, still 
remember, thanks!). What I've been missing since 1st day was a decent, Linux native
client. That's why I've been using webapp (which is a really nice piece of work, but
sometimes performs terribly).

There's always been this [Nevernote](http://nevernote.sourceforge.net/) app, which was
a desktop open-source client for Evernote, later called **Nixnote** and project webpage
was moved [here](https://sourceforge.net/projects/nevernote/?source=navbar).

Back then version 1.x was developed in Java and it's performance was even more 
terrible than native Evernote webapp. But since couple of months we've got a solution
- guys created 2.x version which is based on QT and performs really good. It's still in
beta however but "so far so good" :)

As usual I created ansible-role for this Nixnote - it's very simple - you can check it
in my [fedora-desktop-ansible](https://github.com/docent-net/fedora-desktop-ansible) project
on github.