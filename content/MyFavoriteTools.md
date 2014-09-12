Title: Ansible Playbook for favtools
Date: 2014-09-12 23:24
Category: tech
Tags: ansible,centos,fedora
Author: Maciej Lasyk
Summary: Ansible-playbook for installing my favorite sys-tools on Fedora/Centos

### playbook ###

This rather doesn't fit my github repo ;)

```bash
- name: Ensure my favorite tools are installed
  yum: pkg={{item}} state=latest
  with_items:
    - strace
    - ltrace
    - tcpdump
    - vim
    - procps
    - sysstat
    - git
    - make
    - gcc
    - tmux
    - links
    - man
    - ntp
    - ntpd
    - bind-utils
    - nmap
    - wget
    - telnet
```

That is only for starters; I'd add here also [sysdig](http://www.sysdig.org/) and whole playbook for preparing user env.
