Title: Running sshd on 443/tcp
Category: tech
Tags: selinux,sshd,tcp,security
Author: Maciej Lasyk
Summary: Managing Selinux context regarding 443/tcp port

<center>![Selinux]({filename}/images/selinux-logo.png)</center>

### What? ###

So I had this need to run **ssh** daemon on port 443/TCP. I reconfigured sshd daemon, iptables and stucked with Selinux
policy, when I wanted to assign port 443 to sshd_port_t (so I thought I'd need to remove in the first step actual 
assignment of port 443 which is http_port_t):
 
```bash
[root@srv ~]# semanage port -d -t http_port_t -p tcp 443                                                                                                          
ValueError: Port tcp/443 is defined in policy, cannot be deleted
```

### SSH on port 443? sshd configuration + iptables ###

Yup, it happens ;)

It's simple reconfiguration done in **/etc/ssh/sshd_config**:

```bash
Port 22
Port 443
```

So as you can see I left sshd running also on port 22/tcp. Also reconfigured iptables (Centos 7, no firewalld yet):

```bash
[root@srv ~]# grep 443 /etc/sysconfig/iptables
-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
```

### Back to Selinux - how to fix this? ###

Actually answer lays in documentation:

```bash
$ man semanage-port

       -m, --modify
              Modify a record of the specified object type

```

So basically instead of removing this httpd_port_t assignment, what is impossible without recompiling the policy I just
modified it:

```bash
[root@srv ~]# semanage port -m -t ssh_port_t -p tcp 443
```

And now we have:

```bash
[root@netrunner ~]# semanage port -l | grep 443                                                                                                                         
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
ssh_port_t                     tcp      443, 444, 22
```

Works for me ;)