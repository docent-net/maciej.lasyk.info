Title: DNS views in BIND
Date: 2014-09-02 08:15
Category: tech
Tags: dns,bind
Author: Maciej Lasyk
Summary: How to configure BIND DNS server so it can provide different views of zones for different groups of users?

### Why would I use DNS BIND views? ###

From the manual: **The view clause allows BIND to provide different
functionality based on the hosts accessing it.**

So basically you can provide one group of users with one variant of same zone 
and different part of users with other variant of zone file.

This is very important - I've seen many poor - man's solutions when there was a
need to provide different views in DNSes. **view** clause is the proper
solution.

### How? ###

**view Clause Syntax:**

    :::bash
    view "view_name" [class] {
          [ match-clients {  address_match_list } ; ]
          [ match-destinations { address_match_list } ; ]
          [ match-recursive-only { yes | no } ; ]
          // view statements
          // zone clauses
    };

So i.e. when we want to serve different view for **lasyk.info** domain for 2
grups of users (one would be guys from internet, second - guys from my LAN) we
would do something like this:

**set up proper ACL:**

    :::bash
    acl internal {
           192.168.10.0/24;
           localhost;
    };

**define zone:**

    :::bash
    view "internal-view" {
          match-clients { internal; };
          recursion yes;

          zone "lasyk.info" IN {
                type master;
                file "internal.lasyk.info.conf";
                allow-transfer { any; }
          };
    view "external-view" {
          match-clients { any; };
          recursion no;
          
          zone "lasyk.info" IN {
                type master;
                file "external.lasyk.info.conf";
                allow-transfer { none; };
          };

Now just create proper zone - files, **rndc reload** and test it with **dig**
