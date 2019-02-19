Title: MariaDB multi master replication
Category: tech
Tags: mariadb, mysql, databases, fedora
Author: Maciej Lasyk
Summary: about connecting one slave to two different master servers.

<center>![MariaDB]({filename}/images/mariadb-logo.png)</center>

## What this is about ##

So I have couple of MariaDB servers and wanted to take backups of some of 
databases hosted on those servers. I could simply schedule an [systemd-timer](https://www.freedesktop.org/software/systemd/man/systemd.timer.html)
job on every of those machine that would simply [mysqldump](https://mariadb.com/kb/en/library/mysqldump/)
required databases on regular basis - let's say every our. And then send it
somewhere. Or make external service fetch those backups regularly.

But I don't like this idea. First of all because it increases my [RPO](https://www.druva.com/blog/understanding-rpo-and-rto/),
and secondly - in case one of those DB servers is down I'd have to redeploy it,
load backups etc. It takes time.

So instead of this idea (an old one, mentioned years ago in 2010 in [Mysql High Availability](http://shop.oreilly.com/product/9780596807290.do))
is to replicate all databases to a slave servers and take backups of all slave
DBs.

However this wasn't easy to perform back then in MySQL, because there was no
such thing as multi - master replication. Basically you can't start replication
from more than one master. In MySQL you had to run separate slave server for 
each master you replicated.

And in MariaDB 10 You can finally do this. This image show the idea (I took it 
from mariadb.com page):

<center>![MariaDB]({filename}/images/mariadb-multi_source_replication_small.png)</center>

## Ok, how to do this? ##

In my scenario I had 2 already running MariaDB 10.x servers (from Fedora 
upstream) and a fresh one, that I pointed to be the slave for above masters.

Also a downtime for each master is needed for a time of taking full backup. I
didn't find an easy way to get around this. If you do - please leave a 
comment - thx!

Last, but not least - I used mariadb-server version **10.1.26**.

#### 1. Take backups of both masters.

Should I really write this point? ;)

#### 2. Prepare your masters' configurations

Now we need to make both master servers actual masters :) In order to do that
I edited **/etc/my.cnf.d/mariadb-server.cnf** (find your own **my.cnf** file - 
probably in **/etc/my.cnf**) and put there something like this (of course leave
other configuration options that lay there):

```bash
# first master server my.cnf file

[server]
log-bin
server_id=1
log-basename=master_rss
binlog-ignore-db=mysql

[mysqld]
gtid-domain-id=1
gtid-ignore-duplicates=ON
```

```bash
# second master server my.cnf file

[server]
log-bin
server_id=2
log-basename=master_retromtb
binlog-ignore-db=mysql

[mysqld]
gtid-domain-id=2
gtid-ignore-duplicates=ON
```

So a bit of explanation:

- **log-bin** - thanks to this server will become master and start logging 
binary log. This means, that a log of changes will be saved to files and later
sent to slaves and replayed there. See [this article](https://mariadb.com/kb/en/library/activating-the-binary-log/)
for more information.
- **server_id** - basically keep this value unique for every server in your
replication topology. This must be a number.
- **log-basename** - will be used as a part of name for log-bin files
- **binlog-ignore-db** - this tells which databases must not be replicated. 
Very useful when you want to replicate all DBs but for some set of system DBs.
- **gtid-domain-id** - basically keep this unique for every master. [Here you 
can read](https://mariadb.com/kb/en/library/gtid/#use-with-multi-source-replication-and-other-multi-master-setups) 
details about GTIDs in multi - source replication topologies.
- **gtid-ignore-duplicates** - this is actually not very needed in my 
replication topology. Thanks to this setting when slave receives event with 
GTID that was already processed it will ignore it. It is possible in situation
when you have a chain of master-slave/master-slave replications.

#### 3. Prepare masters data for sending to slave

Execute this for every master. I did it on both of my servers:

1. This procedure execution time mostly depends on how long it takes to take
full backup of required databases. You can test it by running **time mysqldump --databases db1,db2,db3 -u some_user -p > dbs.sql**
beforehand.
1. Restart Mariadb service in order to apply above configurations (this might 
be not needed as probably you can set above setting from mariadb SQL console 
during runtime - you can easily find how to do that in the internets; just a 
note for people who wanna minimize downtime).
1. Log into Mariadb SQL console and execute: **FLUSH TABLES WITH READ LOCK;** -
this will lock and disable all writes to this server. Prior to doing that I
always shutdown HTTP services or put them in maintenance mode. Keep in mind 
that also some cron/timers services might try to connect. Thus locking on DB
layer is most save.
1. Execute **select @@gtid_binlog_pos;** and save this position for later use.
1. Take backup of required databases: **mysqldump --databases db1,db2,db3 -u some_user -p > dbs.sql**
1. When this is finished unlock tables in SQL console: **UNLOCK TABLES;**
1. Copy **dbs.sql** to the slave server.
1. Create replica user: **GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%' IDENTIFIED BY 'replica_password';**

#### 4. Prepare slave server configuration

My **/etc/my.cnf.d/mariadb-server.cnf** looks like this (removed everything
that was not connected to replication):

```bash
[server]
server_id=1000

[mysqld]
gtid-ignore-duplicates=ON
```

So as you can see - a very simple config.

Now you need to upload both backups:

```bash
mysql -u some_user -p < dbs.sql
mysql -u some_user -p < dbs2.sql
```

Having it uploaded it's time for starting replication:

1. Execute **SHOW ALL SLAVES STATUS\G** - this should return an empty set (no
replication running for now).
1. Restart Mariadb service so new config is applied.
1. Run **SET GLOBAL gtid_slave_pos = "1-1-X,2-2-Y";** replacing each position 
with proper you saved during taking backup on master.
1. For each master server setup replication: CHANGE MASTER 'master_name' 
TO master_host="master_ip_addr", master_port=3306, master_user="replica_user", 
master_use_gtid=current_pos, master_password='replica_user_pwd';
1. Now in order to start replication simply run: **START ALL SLAVES;** and
see if no problems were reported: **SHOW WARNINGS;**
1. See replica status: **SHOW ALL SLAVE STATUS\G;**

And that's it.

#### Debugging and solving problems

You will probably hit some problems during setting this up for the first time.
Some helpful commands:

##### Resetting master 

E.g. in order to create once again data backups for uploading to slaves: 

**RESET MASTER** (run this on master)

1. Resetting one slave in order to recreate and reconfigure particular 
replication: 
  1. **RESET SLAVE 'master_name' all**
  1. afterwards you need to **STOP ALL SLAVES;** 
  1. set proper **gtid_slave_pos** by **SET GLOBAL... (check current GTID and replace the incorrect part with the proper one)
  1. again **CHANGE MASTER...** and **START SLAVE master_name;**
1. If you encounter replication error and resolve it somehow than in order to 
skip it you will need to: 
  1. **STOP SLAVE 'master_name'; 
  1. SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; 
  1. START SLAVE 'master_name';**
  
This way you can skip one error (increase error counter to skip more than one)
 
## Helpful resources ##

You can read about it more here:

- <https://mariadb.com/kb/en/library/multi-source-replication/>
- <https://mariadb.com/kb/en/library/multi-master-replication/>
- <https://mariadb.com/kb/en/library/gtid/>
- <https://mariadb.com/resources/blog/mariadb-10-gtid-explained/>
- <https://www.percona.com/community-blog/2018/09/10/multi-master-with-mariadb-10-tutorial/>
