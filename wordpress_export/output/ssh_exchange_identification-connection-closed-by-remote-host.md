Title: ssh_exchange_identification: Connection closed by remote host
Date: 2012-01-30 17:05
Author: docent
Category: ssh
Tags: ssh, sshd
Slug: ssh_exchange_identification-connection-closed-by-remote-host
Status: published

<!--:en-->Recently trying to connect via **ssh** using **cssh** to a
particular server from 26 other boxes at the same time I wasn't able to
connect from some of those boxes and saw this message on those:

    [root@machine .ssh]# ssh -p 56789 user@othermachine.com
    ssh_exchange_identification: Connection closed by remote host

This was due to server configuration. Maximum default number of
simultaneous connections tries (login attemps) is defined in
**/etc/ssh/sshd\_config**:

    MaxStartups 10

We can change above value or use new-style format:

    MaxStartups 10:30:60

Which stands for:

1.  10 - number of allowed simultaneous connections attempts. Above this
    number SSHD will start to randomly drop connections with percentage
    chance of 30%
2.  60 - number of simultaneous connections attempts after which SSHD
    will drop every new connection

<!--:-->
