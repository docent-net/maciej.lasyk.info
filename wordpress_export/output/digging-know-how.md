Title: Digging know how
Date: 2012-01-13 10:03
Author: docent
Category: tech
Tags: bind, dig, dns
Slug: digging-know-how
Status: published

<!--:en-->**Dig** is one of the most important tools that every sysop
uses in day-to-day work. It gives us the possibility to trace resolving
path of domains, checking status of domain records or even getting whole
definitions of records for a particular domain (under some
circumstances...). We won't write here an essay about DNS and it's
functionality - You san always read it here:
<http://en.wikipedia.org/wiki/Domain_Name_System> or even better,
here: <https://webhostinggeeks.com/guides/dns/>

Assuming, that You ave already dig installed (if not - try **yum install
bind-utils** on CentOs or whatever else on different distros) We can
start with explaining how to use properly dig.

1. Simple query
===============

Let's check Gamedesire's domain **www.gamedesire.com**:

    [docent@docent-desktop ganymede]$ dig www.gamedesire.com

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> www.gamedesire.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<

Above We can see a bunch of data.. "status: NOERROR" is answer status -
NOERROR means, that query was resolved properly. ANSWER SECTION contains
of information about resolved records (here We can see 2 A records for
www.gamedesire.com: 174.123.95.100 and 174.123.95.101). Next We have
AUTHORITY SECTION which gives us an answer to the question: "what are
the authoritative DNS servers for this domain?". We have also some
statistic data (query time, ADDITIONAL SECTION with DNS servers info
etc). And remember to check answer flags (in above example: qr rd ra).
You can find explanation of those in [RFC 1035
§4.1.1.](http://www.freesoft.org/CIE/RFC/1035/40.htm).

What happens when domain name is not resolved properly? Let's try with
non-existing sysop.gamedesire.com:

    [docent@docent-desktop ganymede]$ dig sysop.gamedesire.com

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> sysop.gamedesire.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<

As we can see the answer status is NXDOMAIN here - it means
NoneXistingDomain.

2. Querying specific records
============================

There are plenty of DNS record types. Most commonly used are A, MX, TXT
and CNAME. Here is the explanation and complete list of those types:
<http://en.wikipedia.org/wiki/List_of_DNS_record_types>. So now - how
can We query for a MX domain?

    [docent@docent-desktop ganymede]$ dig mx google.com

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> mx google.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<

So We see above in ANSWER SECTION all found MX records. We can ask for
any record type with this method.

3. Tracing DNS query
====================

Every DNS query takes some hierarchical steps. Knowing those could be
very helpful under some circumstances:

    [docent@docent-desktop ganymede]$ dig +trace www.wikipedia.org

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> +trace www.wikipedia.org
    ;; global options: +cmd
    .           209351  IN  NS  k.root-servers.net.
    .           209351  IN  NS  m.root-servers.net.
    .           209351  IN  NS  j.root-servers.net.
    .           209351  IN  NS  l.root-servers.net.
    .           209351  IN  NS  b.root-servers.net.
    .           209351  IN  NS  f.root-servers.net.
    .           209351  IN  NS  h.root-servers.net.
    .           209351  IN  NS  g.root-servers.net.
    .           209351  IN  NS  c.root-servers.net.
    .           209351  IN  NS  e.root-servers.net.
    .           209351  IN  NS  d.root-servers.net.
    .           209351  IN  NS  i.root-servers.net.
    .           209351  IN  NS  a.root-servers.net.
    ;; Received 512 bytes from 192.168.1.1#53(192.168.1.1) in 693 ms

    org.            172800  IN  NS  b2.org.afilias-nst.org.
    org.            172800  IN  NS  a0.org.afilias-nst.info.
    org.            172800  IN  NS  a2.org.afilias-nst.info.
    org.            172800  IN  NS  c0.org.afilias-nst.info.
    org.            172800  IN  NS  b0.org.afilias-nst.org.
    org.            172800  IN  NS  d0.org.afilias-nst.org.
    ;; Received 437 bytes from 128.8.10.90#53(128.8.10.90) in 379 ms

    wikipedia.org.      86400   IN  NS  ns1.wikimedia.org.
    wikipedia.org.      86400   IN  NS  ns0.wikimedia.org.
    wikipedia.org.      86400   IN  NS  ns2.wikimedia.org.
    ;; Received 147 bytes from 199.19.54.1#53(199.19.54.1) in 332 ms

    www.wikipedia.org.  3600    IN  CNAME   wikipedia-lb.wikimedia.org.
    wikipedia-lb.wikimedia.org. 600 IN  CNAME   wikipedia-lb.esams.wikimedia.org.
    wikipedia-lb.esams.wikimedia.org. 3600 IN A 91.198.174.225
    ;; Received 121 bytes from 208.80.152.142#53(208.80.152.142) in 157 ms

We see above all the DNS query steps - first question to the root
servers for a proper TLD DNS server (org), next the question to the TLD
org's server for a proper wikipedia.org NS servers, and then the
question to the wikipedia's NS servers for a resolution to the name
'wikipedia.org' which appears to be a CNAMEs for something more...

4. Shortening the output
========================

Digging is a quite verbose action - by design - much verbosity is good
for debugging purposes. It's good to know how can We reduce output of
this command - for example when We would like to wrap dig command with
some monitoring script. For this purpose I suggest to get known with:

    +nostats
    +nocmd
    +noquestion
    +short

Let's try with the strongest one from above - **+short** will reduce all
the dig's "noise":

    [docent@docent-desktop ganymede]$ dig +short www.gamedesire.com
    174.123.95.101
    174.123.95.100

We can join **+short** with eg. "+trace":

    [docent@docent-desktop ganymede]$ dig +short +trace www.gamedesire.com
    NS l.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS c.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS g.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS m.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS b.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS a.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS i.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS j.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS d.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS e.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS h.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS f.root-servers.net. from server 192.168.1.1 in 33 ms.
    NS k.root-servers.net. from server 192.168.1.1 in 33 ms.
    A 174.123.95.100 from server 207.218.247.135 in 173 ms.
    A 174.123.95.101 from server 207.218.247.135 in 173 ms.

You can try Yourself with other params.

5. Asking specific DNS server
=============================

It is very good practice during checking DNS resolutions (especially
while transferring domains etc) to ask query to a couple of DNS servers.
We can ask particular DNS server (but only when this server allows us to
do so). Remember that by default dig uses DNSes listed in Your
**/etc/resolv.conf** file. Let's try to ask google's DNSes first:

    [docent@docent-desktop ganymede]$ dig +short @8.8.8.8 www.gamedesire.com
    174.123.95.101
    174.123.95.100

And now some ThePlanet's:

    [docent@docent-desktop ganymede]$ dig +short @ns1.theplanet.com www.gamedesire.com
    174.123.95.101
    174.123.95.100

6. The authority
================

In this example:

    [docent@docent-desktop ~]$ dig www.gamedesire.com @ns1.theplanet.com

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> www.gamedesire.com @ns1.theplanet.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<

We can see, that AA bit is set here (flags: qr aa rd). So
ns1.theplanet.com is authoritative for gamedesire.com domain (as in
AUTHORITY section). Now let's try to dig it again using some other DNS
server:

    [docent@docent-desktop ~]$ dig www.gamedesire.com

    ; <<>> DiG 9.8.1-P1-RedHat-9.8.1-3.P1.fc15 <<>> www.gamedesire.com
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<

Here We can see, that there is no AA bit set, and also TTL values are
lower than 86400 for www.gamedesire.com (We can see 19128 value). Why is
that? Because this answer is cached somewhere in the middle and our
current DNS server is not authorative for gamedesire.com . If We would
repeat this query this TTL value would be dropping every each question.
We can't tell looking at above dig output where this query was cached -
to know this We would have to repeat the query with recursion disabled
and step manually through all the DNS tree (but in 9/10 cases It will be
You local DNS cache... which is caching answers).

7. Tracing DIG execution
========================

As I wrote above We can set **+trace** param using dig to trace
resolving path in the DNS tree. But how can We trace what exact queries
are sent and received? Surely with tcpdump:

    [root@docent-desktop ~]# tcpdump -i p2p1 -s1024 udp port domain
    tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
    listening on p2p1, link-type EN10MB (Ethernet), capture size 512 bytes
    10:54:17.047260 IP pma.local.40206 > 192.168.1.1.domain: 9836+ A? www.gamedesire.com. (36)
    10:54:17.047721 IP pma.local.55428 > 192.168.1.1.domain: 59517+ PTR? 1.1.168.192.in-addr.arpa. (42)
    10:54:17.079337 IP 192.168.1.1.domain > pma.local.55428: 59517 NXDomain* 0/1/0 (109)
    10:54:17.080473 IP 192.168.1.1.domain > pma.local.40206: 9836 2/2/2 A 174.123.95.101, A 174.123.95.100 (146)
    ^C
    4 packets captured
    4 packets received by filter
    0 packets dropped by kernel

From the tcpdump(8) manpage: Name server requests are formatted as:

    src > dst: id op? flags qtype qclass name (len)

I rather suggest reading this manpages Yourself - just look for "UDP
Name Server Requests" section.<!--:-->
