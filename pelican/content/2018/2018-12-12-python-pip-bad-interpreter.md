Title: pip: bad interpreter: Permission denied
Category: tech
Tags: python, pip, rundeck
Author: Maciej Lasyk
Summary: about problems with virtualenvs in Python

So latetly while automating some jobs with [Rundeck](https://www.rundeck.org)
I came across a problem:

```bash
/tmp/11637-10898-rundeck.***-dispatch-script.tmp.sh:
/var/lib/rundeck/workspaces/f86853fb-a1e1-4517-bad8-a17931726d00/10898/
some-directory/ansible-playbooks/some-other-directory/plays/
virtual-env-directory/bin/pip:
bad interpreter: Permission denied
```

Wow, where did it came from?

This works perfectly (running this PIP command) from the CLI. So why under
Rundeck it fails?

So I found out, that this is due to shebang length limitation. On Linux it just
can't be longer than 128 characters ([see BINPRM_BUF_SIZE
here](https://github.com/torvalds/linux/blob/master/include/uapi/linux/binfmts.h#L19)).

So as I didn't want to recompile my Kernel for that to make it work I simply 
made sure that the whole shebang will fit the 128 chars limit by shortening
the path mentioned in error above.

There's also another way - one could create a wrapper script that would run
the original one and run it via **exec** command.

You can read about it more here:

- <https://github.com/pypa/virtualenv/issues/596>
- <https://stackoverflow.com/questions/10813538/shebang-line-limit-in-bash-and-linux-kernel>
- <https://www.in-ulm.de/~mascheck/various/shebang/>
