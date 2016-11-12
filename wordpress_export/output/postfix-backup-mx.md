Title: Postfix: Backup MX
Date: 2012-01-06 14:49
Author: docent
Category: postfix
Tags: dns, email, mx, postfix
Slug: postfix-backup-mx
Status: published

<!--:en-->[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2012/01/tux-mail-1ty.gif "Taken from www.yolinux.com"){.alignright
.size-full .wp-image-116 width="243"
height="244"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2012/01/tux-mail-1ty.gif)In
mail-servers architecture We should always have some backup MX defined
for every mail server. It's very simple why - to have a redundant
mail-server architecture and just to be sure, that no emails are
returned with an error while our mail-server is having issues.

In the simplest scenario let's assume that We have only one mail server
(mail.somedomain.com). We'd like to start a backup MX server for this.
We can do this in a few simple steps:

Step 1: Backup postfix configuration
====================================

On the backup server We should change some postfix configuration in
**main.cf** file. We should add / change **relay\_domains**, set
**maximal\_queue\_lifetime**, **smtpd\_recipient\_restrictions** and We
should create **relay\_recipient\_maps**:

    relay_recipient_maps = hash:/etc/postfix/relay_recipients
    maximal_queue_lifetime = 30d
    smtpd_recipient_restrictions =
           [...]
           permit_mx_backup
    relay_domains = $mydestination somedomain.com
    permit_mx_backup_networks = 128.128.128.0/24 201.201.201.0/24

Now let's explain the following configuration:

-   **relay\_recipient\_maps = hash:/etc/postfix/relay\_recipients** -
    this is optional, but I advise to use this parameter. It defines a
    hash table containing valid recipients. If the backup system
    wouldn't know all the valid mailboxes it would have to accept all
    the emails - including spam for non-existing adresses. With
    knowledge of legal addresses backup server is able to bounce back
    emails that have invalid recipient set. This does not apply in
    environment using catchall mailboxes to catch all the emails. I
    attached a sample relay\_recipients file below. Remember to use
    postmap command after every change in this file: **postmap
    /etc/postfix/relay\_recipients**
-   **maximal\_queue\_lifetime = 30d** - default value for Postfix is
    5 days. This number sets the time period in which backup server will
    try to deliver emails to the main server - so this is maximum time
    of downtime for main server until mails are bounced back to their
    original senders with an error.
-   **relay\_domains = \$mydestination somedomain.com** - this parameter
    will allow postfix to relay emails for **somedomain.com**
-   **permit\_mx\_backup** - security, see
    <http://www.postfix.org/postconf.5.html#permit_mx_backup>
-   **permit\_mx\_backup\_networks** - security, see
    <http://www.postfix.org/postconf.5.html#permit_mx_backup_networks>

And the sample relay\_recipients\_file:

    user1@somedomain.com   any_value
    user2@somedomain.com   any_value
    user3@somedomain.com   any_value
    user4@somedomain.com   any_value
    user5@somedomain.com   any_value

So as You see - You should have replicated users addresses on the MX
server in the relay\_recipients file.

Step 2: DNS configuration
=========================

Having only one mail server it is enough to have only one MX record in
our DNS zone file:

    [user@server ~]# dig mx somedomain.com
    ;; ANSWER SECTION:
    somedomain.com.     86400   IN  MX  10 mail.somedomain.com.

Here We see our only MX record with 10 priority pointing to the A record
mail.somedomain.com. In order to create a new record for our backup MX
server We should first add a new A record, like:

    mail2.somedomain.com.    86400   IN  A   129.129.129.129

And then We can create a new MX record with lower priority:

    mail.somedomain.com. 86400   IN  MX  20 mail2.somedomain.com.

Step 3: Flushing messages
=========================

When main MX server is down, and backup server gets some messages to
hold those until main server is back - It moves those messages
immediately to the flush queue. Now those messages can be delivered via
flush daemon, which is run every some time (set in
**/etc/postfix/master.cf**):

    flush     unix  n       -       n       1000?   0       flush

Here the "1000?" stands for 1000 seconds every which flush daemon is
activated (until it is not already running - this is why we use here
question mark after 1000).

Now we can set how often messages should be flushed via the running
flush daemon using the **fast\_flush\_refresh\_time** param (default set
to 12h). So every 12h messages that haven't had redelivery requested are
being kicked automaticly.

When our master server is back We could just flush all the messages
manually:

    postqueue -f

But above command will flush all the messages in the flush queue - this
might not be the best solution as the backup MX can be a slave for a
bunch of main MX servers - are you sure You would like to flush all
those messages from all those servers when only one is back online?

Better solution is to use:

    postqueue -s somedomain.com

Above command will flush only the messages from the given domain - and
that's what We would like to do. But We have to know, that We can use
this command only when We have this domain configured as
"fast\_flush\_domains". Again - We're lucky, because default
"fast\_flush\_domains" value is:

    fast_flush_domains = $relay_domains

And If We configured our somedomain.com as "\$relay\_domain" - then our
flush command will work :) If not then We only have to set:

    fast_flush_domains = $relay_domains somedomain.com

And when our main MX comes back again - We can flush this domain on the
backup MX - it's good to be wrapped with some script :)

And We're good to go - from now (after correct DNS entries' propagation,
so in max 72 hours) our backup MX should work and receive emails when
master mail server is offline.<!--:-->
