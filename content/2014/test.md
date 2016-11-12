Title: Moving to Pelican
Date: 2014-08-08 00:21
Category: pelican
Tags: pelican
Author: Maciej Lasyk
Summary: Maybe at least. Pelican?

So it finally happened. After 6 months I started migrating my blog from crapy
Wordpress to [Pelican](https://github.com/getpelican/pelican/). There're still plenty of things I have to take care of:

- git automation (pull / push)
- some commenting functionality
- layout polishing (current layout is based on [monospace](https://github.com/getpelican/pelican-themes/tree/master/monospace)
- slug (call it: modrewrite / url fixing)
- images upload handling (I want all images I use in post content to be uploaded and reformatted automatically
- code syntax highlightning
- [plugins](https://github.com/getpelican/pelican-plugins) review
- RSS handling
- tag cloud (I'll use only that instead of categories)
- maybe some spell - check? or rather will stick to VIM - based
- migrating posts from my old Wordpress - blog

Looks like a plate is full. ETA? Will be delivered somehow between Monday and
end of the next year ;)

What's beautiful here? It's 100% Markdown <- Pelican <- Nginx <- Docker <-
Fedora <- my home server :)
