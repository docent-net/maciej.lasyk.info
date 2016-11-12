Title: MySQL replication over SSH tunnel
Date: 2011-12-24 23:37
Author: docent
Category: tech
Tags: mysql, replication, ssh, tunnel
Slug: mysql-replication-over-ssh-tunnel
Status: published

<!--:en-->Sometimes it is a good decision to replicate between
datacenters. It is not for a backup purposes - as replication cannot be
used for backups (maybe under some circumstances, but let's say that for
now We're not thinking about replication as backup solution) - for now
We're using it to just have up2date data in some other datacenter.

General idea to set up this replication is to make a SSH tunnel between
those two datacenters and then start transferring data using this secure
transport layer. I will call "replication server" - the server that will
be slave in our destination and "the master server" will be our master.

I won't write here how to set up a replication from the scratch. Let's
say that for now there are at least two ways to do it without stopping
mysql master (using another slave to take data snapshot or using
[Percona
Xtrabackup](http://www.percona.com/doc/percona-xtrabackup/howtos/setting_up_replication.html)).

Firstly we have to start SSH tunnel. We have to ensure, that this tunnel
will keep alive trough any connection problems and will not be killed
due to an idle (how come when there is replication stream over this?).

Let's start with ensuring that our tunnell will keep alive. In SSH
client configuration (default: /etc/ssh/ssh\_config) We should add the
following:

    ServerAliveInterval 300

</code>

With above server maintaining the tunnel will send some keep-alive
request every 300 seconds to the master (destination) server.

Now We have to open MySQL port on the master (destination) server on WAN
interface. This is not secure unless We filter source IP address trying
to connect to this port (let's allow only our slave's server IP addr. to
use this port). For maximum security We can use TCP Wrappers on the
master (destination) MySQL server, but this will put some overhead to
the server functionality as TCP Wrappers always use some DNS resolution.
In my opinion filtering MySQL port based on source IP address is enough.

Now We can start our tunnel:

    ssh -p 2345 -f mysql_tunnel@mysqlmaster-server.com -L 4406:mysqlmaster-server.com:3306 -N

</code>

Let's explain:

-   **-p 2345** - port We are using to connect over SSH (default 22, but
    should be changed to something else for standard security reasons)
-   **-n** - SSH will go to background just before command execution.
    Make sure, that You have SSH keys exported to the
    master (destination) server from the slave server / user and You
    will not have to enter any passwords during creating the tunnel
-   **-L** - turns on port forwarding - this is the core of creating SSH
    tunnel
-   -   **-N** - "do not execute a remote command" - just because We are
    just forwarding ports :)

Now We can test this tunnel. Let's try to connect to MySQL master from
the slave server:

    mysql -h 127.0.0.1 -p 4406 --user=replication

</code>

We should be able to connect to the master server with above command.
And If We really did - then We can use this connection to start the
replication.

This is very simple method that should be wrapped with some monitoring,
scripts that will create SSH tunnels automatically when the original
tunnel dies or after server crash. We should also remember, that
replication lags can be quite high using this technique - everything
depends on connection quality and number of writes on master that will
have to be replicated on slave. In order to tune this method of
replication It can be good to use statement-based replication - because
in many cases this method use a bunch less number of kilobytes to
transmit replication data to the slave.<!--:-->
