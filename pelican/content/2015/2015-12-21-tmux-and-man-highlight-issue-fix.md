Title: Fixing text highlighting in tmux/man/less 
Category: tech
Tags: tmux,screen,man
Author: Maciej Lasyk
Summary: Ansible role providing fix for a nasty tmux issue

<center>![tmux]({filename}/images/tmux.png)</center>

So today I spotted an in issue while using search function when reading man
pages. Basically **I didn't have results highlighted**, but search worked
(position of screen scrolled to somewhere near first spotted result).

Firstly tried to blame [Terminator](https://en.wikipedia.org/wiki/Terminator_%28terminal_emulator%29)
but I had same issue in [Guake](https://en.wikipedia.org/wiki/Guake) session. Finally I found that
the common denominator here was tmux. Outside of tmux there was no such problems.

### Solution?

So I dug the internets and [found a solution](http://tmux.svn.sourceforge.net/viewvc/tmux/trunk/FAQ):

*vim displays reverse video instead of italics, while less displays italics
  (or just regular text) instead of reverse. What's wrong?*

*Screen's terminfo description lacks italics mode and has standout mode in its
place, but using the same escape sequence that urxvt uses for italics. This
means applications (like vim) looking for italics will not find it and might
turn to reverse in its place, while applications (like less) asking for
standout will end up with italics instead of reverse. To make applications
aware that tmux supports italics and to use a proper escape sequence for
standout, you'll need to create a new terminfo file with modified sgr, smso,
rmso, sitm and ritm entries:*

    $ mkdir $HOME/.terminfo/
    $ screen_terminfo="screen"
    $ infocmp "$screen_terminfo" | sed \
      -e 's/^screen[^|]*|[^,]*,/screen-it|screen with italics support,/' \
      -e 's/%?%p1%t;3%/%?%p1%t;7%/' \
      -e 's/smso=[^,]*,/smso=\\E[7m,/' \
      -e 's/rmso=[^,]*,/rmso=\\E[27m,/' \
      -e '$s/$/ sitm=\\E[3m, ritm=\\E[23m,/' > /tmp/screen.terminfo
    $ tic /tmp/screen.terminfo

*And tell tmux to use it in ~/.tmux.conf:*
    
    set -g default-terminal "screen-it"

*If your terminal supports 256 colors, use:*

    $ screen_terminfo="screen-256color"

*instead of "screen".*
    
### Ansible playbook for this

So I created [Ansible implementation](https://github.com/docent-net/fedora-desktop-ansible/commit/d314aedd61e6973df3de16bd557de7e3f3aecb3d)
and put in inside of [fedora-desktop-ansible](https://github.com/docent-net/fedora-desktop-ansible).
 
You can test it with:

```bash
ansible-playbook master.yml --tags tmux
```

