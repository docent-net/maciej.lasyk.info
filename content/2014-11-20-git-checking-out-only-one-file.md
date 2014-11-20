Title: GIT: clone only one file
Category: tech
Tags: tmux
Author: Maciej Lasyk
Summary: How to checkout only one file from the repo without cloning all the repo?

<center>![GIT]({filename}/images/git.png)</center>

### What? ###

So I have a quite big bare repo somewhere and needed to get only one file from
there (of course - didn't know the exact filename). Frankly my GIT-fu is not 
that kinky, so the way I did it could cause a little bit of smile on someones 
mouth ;)

### How? ###

A slice from my notes:


```bash
# on a local FS:
$ git init . # create empty repo on local FS
$ git remote add remote_name path # add a remote
```

```bash
# on a remote, bare repo:
$ git log -n 10 # get last commits id
$ git show --name-only commit_id # get listing of files from the last commits
```

```bash
# on a local FS:
$ git archive --remote=remote_name HEAD:some/dir/somewhere filename | tar xf -
```

So this way you'll end up with only one file scrapped from the remote repo.
