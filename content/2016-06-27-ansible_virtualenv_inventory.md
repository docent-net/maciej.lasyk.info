Title: Working with virtualenv and Ansible
Category: tech
Tags: ansible, virtualenv, inventory
Author: Maciej Lasyk
Summary: Short story about hacking Ansible && virtualenv

<center>![Evernote]({filename}/images/Ansible_Logo.png)</center>

## What this is about? ##

So after upgrading to [Fedora 24](https://getfedora.org/?wkfpF24) I wanted to have
a clean installation and use only system libraries (no more **sudo pip install..**).
I already achieved that by using
[systemd-nspawn containers](https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html)
for application isolation (instead of using virtual machines) and [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/)
for Python libraries during pydevelopment.

But.. while working with Ansible there's still a problem. E.g. when working with cloud
providers (like AWS, Google, Rackspace, Digital Ocean - you name it) you usually use
local connections for sending API requests, e.g.:

```
- hosts: localhost
  connection: local
  tasks:
  - name: Provision a set of instances
    ec2:
        ...
```

In order to make above working you need to have **boto** and **Ansible** installed on
your box. That's a no - brainer.

But what if every ansible repository contains requirements.txt which declares specific
Ansible and boto versions? E.g.:

```
ansible==2.0.1.0
boto==2.40.0
```

Yes, you could simply:

```
sudo pip install ansible==2.0.1.0
sudo pip install boto==2.40.0
```

But this would actually break your system - wide libraries. If another project needs
**ansible==2.1.0.0** then you're in trouble.

## Ansible and virtualenv? ##
So - the solution is to use [Python virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/).
It might be obvious, but it's not that easy with Ansible. When working from defined virtual environment
and using **local** connection Ansible actually creates SSH connection via loopback device and enters login shell
using configured account (e.g. **remote_user** set it ansible.cfg; more on this topic [here](http://docs.ansible.com/ansible/intro_configuration.html#remote-user).
After logging back in to your account we're using default Python interpreter (global one, probably **/usr/bin/python**) -
not the one we want to (from our virtualenv). Kaboom!

Ok, so there's a solution. It's called **ansible_python_interpreter** and it's mentioned
in [Ansible FAQ](http://docs.ansible.com/faq.html) (but regarding other case). Basically
if we tell Ansible to use Python interpreter from our virtualenv it will work:

```
ansible-playbook -i inventory/ec2.py magic_cloud.yml \
-e "ansible_python_interpreter=/home/ukleftue/.virtualenvs/ilovebaleares/bin/python"
```

In above example virtualenv we use is called **ilovebaleares**.

So using this hack'ish way we can marry Ansible and virtualenvs together.

## There's more to it! ##

Remember that you can have couple of plays in playbook? Imagine, that first play
actually spawns instances (using API calls invoked from local tasks) and second one
applies roles using direct SSH connections to remote (freshly spawned) instances:

```
- hosts: localhost
  connection: local
  tasks:
  - name: Provision a set of instances
    ec2:
        ...
    register: ec2

  - name: Add host to temporary group
    add_host: >
      hostname="{{ item.private_ip }}"
      groupname="tag_awesomehosts"
    with_items: "{{ ec2.tagged_instances }}"
    changed_when: false

- name: Configure instances
  hosts:
  - "tag_awesomehosts"
  roles:
    - do_something
```

So in above example using **ansible_python_interpreter** will work for first play,
but for second it will cause:

**fatal: [some_ip_addr]: UNREACHABLE! => {"changed": false, "msg": "SSH Error: data could not be sent to the remote host. Make sure this host can be reached over ssh", "unreachable": true}**

Why is that? If we run ansible-playbook in verbose mode (add -vvvvv) we'll get:

```
<some_ip_addr> SSH: EXEC ssh -C -vvv -o ControlMaster=auto
-o ControlPersist=60s -o StrictHostKeyChecking=no -o
KbdInteractiveAuthentication=no -o
PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,
publickey -o PasswordAuthentication=no -o User=ec2-user
-o ConnectTimeout=20 -o ControlPath=/tmp/ansible-ssh-%h-%p-%r some_ip_addr
'/bin/sh -c '"'"'sudo -H -S -n -u root /bin/sh -c '"'"'"'"'"'"'"'"'echo
BECOME-SUCCESS; /bin/sh -c '"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'
LANG=C LC_ALL=C LC_MESSAGES=C
/home/ukleftue//.virtualenvs/ilovebaleares/bin/python'
"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"'"''"'"'"'"'"'"'"'"''"'"''
```

Notice last: **/home/ukleftue//.virtualenvs/ilovebaleares/bin/python** - see? This is
our problem - setting **ansible_python_interpreter** works globally for all plays
within playbook.

So I found solution for this - actually you can set **ansible_python_interpreter** per
host basis in inventory (told you that sometimes when I don't hate Ansible I really
love it?). So just prepare yourself file like **inventory/local** which could look
like this:

```
[localhost]
localhost ansible_python_interpreter=/home/ukleftue/.virtualenvs/ilovebaleares/bin/python
```

and run above playbook without passing directly **ansible_python_interpreter** on command
line (as it is already set in inventory), but providing additional inventory file:

```
ansible-playbook -i inventory/ec2.py -i inventory/local magic_cloud.yml"
```

## Whoah, that really works? ###

Erm, SOA#1: Works for me ;)

Enjoy!
