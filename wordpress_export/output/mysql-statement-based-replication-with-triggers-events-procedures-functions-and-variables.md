Title: MySQL statement based replication with triggers, events, procedures, functions and variables
Date: 2012-01-06 13:30
Author: docent
Category: mysql
Tags: mysql, replication
Slug: mysql-statement-based-replication-with-triggers-events-procedures-functions-and-variables
Status: published

<!--:en-->Before starting statement based replication in MySQL database
We have to be aware of some specific behaviors for this environment.
This kind of replication (statement based) writes each query that
modifies data to the **Binary Log** in order to replicate them on the
slave or to use as a **point-in-time recovery** (PITR). Because of this
kind of query logging We should be aware how MySQL replication engine
behaves with some special queries like triggers, functions, procedures
or events.

Functions
=========

Function calls are logged directly to Binary Log, so If You forget to
create on slave any function that is created on master - You will break
your replication and probably You'll see error like below:

    Last_Error: Error 'FUNCTION postfix.recount_quota not exist' on query. Default database: 'postfix'. Query: 'UPDATE user_imap SET quota=(recount_quota())'

</code>

When promoting slave to master no additional steps according to
functions are required - everything is needed is having functions
defined in both: master and slave.

Procedures
==========

Procedure calls are not replicated as in functions - this is important
to know. Only the queries inside the procedures get logged to the Binary
Log, so You don't have to create procedures on slaves.

In order to promote slave to master you should have procedures created
on slave - so it is wise to have all the procedures created on both -
master and slaves.

Events
======

Events created on master server get replicated to the slave with the
**DISABLE ON SLAVE** option - that's why those events are not reexecuted
on every slave in our MySQL architecture and we have no duplicated and
corrupted data. MySQL logs only queries from inside the event so only
those queries are replicated via Binary Log.

In order to promote slave to master according to events we have to do
some more job. I've created a simple event below (We create it on the
master):

    mysql> CREATE EVENT mysql_heartbeat 
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
    DO INSERT UPDATE `mysql_stat`.`heartbeat` SET `last`=CURTIME();

</code>

Now it's replicated on slave via Binary Log - below I've placed
replication entry for that event from Binary Log:

    CREATE DEFINER=`user`@`localhost` EVENT `mysql_heartbeat` ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE DO INSERT UPDATE `mysql_stat`.`heartbeat` SET `last`=CURTIME();

</code></code>

And how it looks like after replication on the slave:

    CREATE DEFINER=`user`@`localhost` EVENT `mysql_heartbeat` ON SCHEDULE AT '2012-01-06 21:12:56' ON COMPLETION NOT PRESERVE DISABLE ON SLAVE DO INSERT UPDATE `mysql_stat`.`heartbeat` SET `last`=CURTIME();

</code>

So now with this knowledge a little procedure to promote slave to master
using events:

-   Disabling event manager on slave with **SET GLOBAL event\_scheduler
    = OFF;**
-   Enabling all the events with **ALTER EVENT \`event\_name\`
    ENABLE** - We have to do this for each event, so writing a little
    script is very helpful here.
-   Enabling event manager with **SET GLOBAL event\_scheduler = ON;**

In order to demote back the master to slave You should follow the
previous procedure with a little change on ALTER EVENT - here You just
need to DISABLE all the events (not ENABLE).

Triggers
========

In order to have triggers running properly on master and slaves You have
to define them in both - master and slave servers. MySQL statement based
replication replicates only the original query to the Binary Log - not
the subsequent triggered statements.

When promoting slave to master no additional steps according to triggers
are required - everything is needed is having triggers defined in both:
master and slave.

Mixed triggers / procedures / functions calls
=============================================

Let's imagine that We have a trigger, that triggers a procedure which
uses a function call. How will this behave in statement based
replication?

1.  We should have trigger defined on both: master and slave
2.  We don't have to have procedure defined on the slave - only on
    master is enough
3.  We should have function defined on both: master and slave

Despite of all - my advice is to keep function, triggers, procedures and
events defined on all the servers (masters and slaves) - just to be
sure, that We can always promote slave to master without any issues.

And one more thing before finishing this post. If You plan to start
replication with just copying FRM, MYI, MYD and InnoDB files You should
also dump any functions / triggers and stored procedures on master (or
slave) and then import those on the new slave. You can do it (for every
database) with:

    mysqldump --routines --no-create-info --no-data --no-create-db --skip-opt <database> > dumpfile.sql

And recreate those on the new box:

    mysql <database> < dumpfile.sql

<!--:-->
