Title: Tmux: join-pane
Category: tech
Tags: tmux
Author: Maciej Lasyk
Summary: Moving panes between windows

<center>![TMUX]({filename}/images/tmux.png)</center>

Today I finally learnt how to move a pane between windows in
[Tmux](http://tmux.sourceforge.net/) and yes - I will share this vodoo
knowledge with you guys.

Searching through the internet gives us this:

```bash
# pane movement
bind-key j command-prompt -p "join pane from:"  "join-pane -s '%%'"
bind-key s command-prompt -p "send pane to:"  "join-pane -t '%%'"
```

This is the most popular binding for this 'moving' purposes. But - when you try
it entering window number as the destination (or source) you get a message:

> Can’t join a pane to its own window

WTF?

Let's RTFM:

>      join-pane [-bdhv] [-l size | -p percentage] [-s src-pane] [-t dst-pane]
>            (alias: joinp)
>           Like split-window, but instead of splitting
>           dst-pane and creating a new pane, split it and
>           move src-pane into the space.  This can be used
>           to reverse break-pane.
           
Yes - so this gives us nothing.

So - lurking through the horizon of the internet I found
[this](https://forums.pragprog.com/forums/242/topics/10533):

So it looks like the full path takes 2 arguments: window_number.pane_number

So yes - bindings are still valid but instead entering single window number we
should enter exact location like **1.3** (assuming you got at least 2 panes in
1 window)

Yes - this was not that obvious
