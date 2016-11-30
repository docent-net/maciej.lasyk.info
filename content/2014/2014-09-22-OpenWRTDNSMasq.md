Title: OpenWRT, Dnsmasq + external DNS
Category: tech
Tags: dns,openwrt,dnsmasq,dhcp
Author: Maciej Lasyk
Summary: How to setup OpenWRT/DHCP with external DNSes

I use [OpenWRT](https://openwrt.org/) on my home access - points instead of
stock software (due to security concerns and my OpenSourceTheWorld approach).

I also have [BIND](https://en.wikipedia.org/wiki/BIND) in use on my
home-server, so I can use e.g. [zones]({filename}/2014/DnsBindViews.md).

So I was trying to make OpenWRT send DNS IP address to DHCP clients. By default
OpenWRT will send it's own IP (it's using Dnsmasq onboard). And I just couldn't
find option to set this manually (using webinteface).

Finally I logged into CLI interface via SSH and found that this change can be
made in two ways.

In **/etc/dnsmasq.conf** by adding line:

    :::bash
    dhcp-option=6,IP1,IP2

Or in **/etc/config/dhcp** by adding to the section **config dnsmasq**:

    :::bash
    list 'dhcp_option' '6,192.168.1.29'

Just restart Dnsmaq service afterwards and you're done.
