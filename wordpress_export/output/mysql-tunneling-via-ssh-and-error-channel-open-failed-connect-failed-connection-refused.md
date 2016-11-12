Title: MySQL tunneling via SSH and error "channel: open failed: connect failed: Connection refused"
Date: 2011-12-28 13:48
Author: docent
Category: mysql, ssh
Tags: mysql, ssh, tunnel
Slug: mysql-tunneling-via-ssh-and-error-channel-open-failed-connect-failed-connection-refused
Status: published

<!--:en-->Lately I wrote a [short
article](http://maciek.lasyk.info/sysop/2011/12/24/65/) about MySQL
tunneling via SSH in order to start safe MySQL replication. Afterwards I
noticed some problems with creating a new SSH tunnel for MySQL
connection on a quite different environment. After creating SSH tunnel
and trying to connect via this tunnel to the SSH server I received SSH
error on tunnel error-log:

    channel 2: open failed: connect failed: Connection refused

</code>

or:

    channel 3: open failed: connect failed: Connection refused

</code>

And below:

    ERROR 2013 (HY000): Lost connection to MySQL server during query

</code>

in the MySQL terminal.

First of all We have to make sure, that our tunnel is working properly,
so We just kill the current tunnel and create new one without "**-f**"
and "**-N**" options:

    ssh -p 2345 mysql_tunnel@mysqlmaster-server.com -L 4406:mysqlmaster-server.com:3306

</code>

If everything is ok, then We can assume that tunnel is working fine. We
can also try to create another tunnel to some other service on different
target port and then just try if this other service is working via the
tunnel - just to exclude any problems with SSH tunneling.

My problem was that MySQL was configured in the way it was blocking any
connections outside localhost. It is default MySQL configuration - We
can achieve it via **my.cnf** entries:

    bind-address = 127.0.0.1

</code>

or:

    skip-networking

</code>

So in order to make our MySQL accessible via our tunnel We have to
comment out the **skip-networking** line and make sure that We are
connecting to the correct IP addr in our tunnel. For example If we have
in our **my.cnf** this line:

    bind-address = 127.0.0.1

</code>

Then our tunnel should look like:

    ssh -p 2345 -f mysql_tunnel@mysqlmaster-server.com -L 4406:127.0.0.1:3306 -N

</code>

(notice that 127.0.0.1 in the above command).

If We would bind our MySQL to some other IP, like:

    bind-address = 192.168.0.12

</code>

Then We should change our tunneling parameters:

    ssh -p 2345 -f mysql_tunnel@mysqlmaster-server.com -L 4406:192.168.0.12:3306 -N

</code>

After commenting out that **skip-networking** our security depends on IP
address We are binding the MySQL to. If it's local IP addres in DMZ,
than there is no security breaches here. Unwise would be to bind to the
WAN address and leave MySQL port opened without any SSL encryption or
without filtering traffic by the client IP addr...<!--:-->
