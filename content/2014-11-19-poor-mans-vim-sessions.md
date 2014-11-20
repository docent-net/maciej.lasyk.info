Title: Poor man's VIM sessions
Category: tech
Tags: vim, sessions
Author: Maciej Lasyk
Summary: How I handle sessions in VIM

<center>![VIM]({filename}/images/vim.jpg)</center>

Some of guys use VIM just like Eclipse - one IDE to rule them all. I don't like
this approach - instead of this I rather work in couple of
[Tmux](http://tmux.sourceforge.net/) windows having exactly one VIM in each (usually top - left pane). 

If you don't know what Tmux is and how it works check this [crash course](http://robots.thoughtbot.com/a-tmux-crash-course) or [this comparison between GNU Screen and Tmux](http://www.techrepublic.com/blog/linux-and-open-source/is-tmux-the-gnu-screen-killer/).

So - instead of opening new VIM windows and sessions manually everytime I
start my work I just start vim using bash function (placed in my zsh_profile):

> $ vims session_name

This way I keep one session per task (just like I do with Tmux windows - think 
about those like feature branches in git!).

So the whole workflow looks like:

1. Create new tmux windows with my custom layout (using [Tmuxinator](https://github.com/tmuxinator/tmuxinator))
1. Create feature branch in git repo
1. Open VIM in the top - left pane of VIM using session named exactly the same 
   like feature branch

Yes - I could possibly remove the last step and include it into the tmux 
window creation, but remember - this is **poor man's way** ;)

And one more thing - I use [vim-session](https://github.com/xolox/vim-session)
plugin to handle sessions in VIM.

And the function code? See below:

```bash
vims() {
    _vim_sess_dir=~/.vim/sessions/
    if [ -z $1 ]; then
        echo "You must enter session name!"
        ls $_vim_sess_dir
    else
        _vim_sess=$_vim_sess_dir/$1
        if [ ! -f $_vim_sess ]; then
             cp $_vim_sess_dir/default.vim $_vim_sess
        fi
        vim -S $_vim_sess
    fi
}
```
