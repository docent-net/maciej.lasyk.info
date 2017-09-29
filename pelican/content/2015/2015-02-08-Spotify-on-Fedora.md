Title: Spotify on Fedora 21
Category: tech
Tags: spotify,fedora
Author: Maciej Lasyk
Summary: How to run native Spotify client on Fedora 21?

<center>![Spotify and Fedora]({filename}/images/fedspotify.png)</center>

### Spotify on Fedora? ###

Yup, I just got bored of running Spotify on my cellphone when working on
computer. Unfortunately there is no native support for Spotify on Fedora just
like in Debian / Ubuntu (which are preferred distros by Spotify for Linux
today).

### So howto Spotify and Fedora? ###

Quit simple, but a bit kinky ;)

- [Install rpmfusion repo](http://rpmfusion.org/Configuration)
- Install Spotify client: ***yum install lpf-spotify-client***
- This client has some old dependency (libgcrypt.so.11), which is not (and 
  will not be) in F21. However I found it in [this
  COPR](https://copr.fedoraproject.org/coprs/red/libgcrypt.so.11/), so simple
  install [this
  repo](https://copr.fedoraproject.org/coprs/red/libgcrypt.so.11/repo/fedora-rawhide/red-libgcrypt.so.11-fedora-rawhide.repo)
  and ***yum install compat-libgcrypt***
- Now just type in terminal: ***lpf update*** and you will get a popup window
  w/Spotify client updater/installer.

If you have any issues installing see buildlog (you can view it from this popup
window)
