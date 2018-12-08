Title: Override DNS records with BIND and Response Policy Zones
Category: tech
Tags: dns, bind, rpz
Author: Maciej Lasyk
Summary: How to override any DNS records fom public DNS servers using your local DNS server 

## What this is about ##

I'm hosting my own BIND server on my local network. It's a caching - resolving
server, that speeds up my whole home network.

It works across couple of VLANs and provides different [views of DNS zones](https://kb.isc.org/docs/aa-00851).

However I have couple of public domains (e.g. lasyk.info) which are hosted in 
public DNS providers (in this case it's [Cloudflare](https://www.cloudflare.com0)). 
And I can't use BIND zones there.

So now I have a **service.lasyk.info** hosted on my local network but the
A record for this service setup in Cloudflare is my public IP address of my
home network. And I can't access it from within this network because I don't 
have such complicated routing setup (and I don't want to). Basically I'd need
to route my requests to this local service outside of my network and then back
inside. Quite stupid.

So I want to do some magic with my local BIND and make it override some of
public DNS entries. E.g. this **service.lasyk.info** should return A record
pointing at local IP address.

And this is exactly what Response Policy Zones in BIND are all about. All over
since 2010 :)  

## So, how?

It's simple. In you BIND server (at least 9.8.0 version) simply define new 
zone:

```bash
/etc/named.conf
---
zone "rpz" {              
  type master;                                               
  file "/etc/named/overrides.rpz";                                
  notify yes;            
#  also-notify { ip.of.your.secondaRy.DNS; };
#  allow-transfer { ip.of.your.secondary.DNS; };
};

# and in options section
options {
    # your other options go here
    # ...
    # ...
    
    # overrides zone:                
    response-policy { zone "rpz"; };
}

```

and define this zone file:

```bash
/etc/named/overrides.rpz
---
$TTL 600
@            IN    SOA  localhost. root.localhost.  (
                          2018120300   ; serial
                          1h           ; refresh
                          30m          ; retry
                          1w           ; expiry
                          30m)         ; minimum
                   IN     NS    desi.ns.cloudflare.com.
                   IN     NS    sean.ns.cloudflare.com.


service.lasyk.info    A       192.168.1.20
service2.lasyk.info    CNAME       google.com
```

Now after restarting BIND server you can dig it to make sure it's overriding
service.lasyk.info name with IP A record defined above.

## Extras

You can also define custom logging channel for this RPZ zone in your BIND 
config:

```bash
/etc/named.conf
---
    channel rpz-queries {
        file "/var/log/named/queries-rpz.log" versions 10 size 500k;
        severity dynamic;                                      
        print-time yes;                     
    };
    
    category rpz { rpz-queries; };

```

## Summary

That's it. Very simple and effective. I didn't know about this feature, as
I learnt most of my DNS skills from [DNS and BIND, 5th edition](http://shop.oreilly.com/product/9780596100575.do)
that was released in 2009 and covered BIND 9.3.2 and above feature comes with
9.8.0