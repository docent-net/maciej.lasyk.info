Title: Network Manager Dispatcher
Date: 2014-09-14 11:46
Category: tech
Tags: network,centos,fedora
Author: Maciej Lasyk
Summary: Short story why one coulde like NetworkManager

[NetworkManager](https://en.wikipedia.org/wiki/NetworkManager) is often 
associated with some voodoo - network - magic tool, that does the work on 
laptop, but better switch it off on server. I won't argue about that, just 
wanted to give you something I personally think make NM more usable.

So it is the **/etc/NetworkManager/dispatcher.d** - this is directory under
which lay scripts which will be executed on network change. Following
man-pages:

*NetworkManager will execute scripts in the /etc/NetworkManager/dispatcher.d 
directory in alphabetical order in response to network events. Each script 
should be a regular executable file, owned by root.*

*Furthermore, it must not be writable by group or other, and not setuid.*

*Each script receives two arguments, the first being the interface name of
the device just activated, and second an action.*

- **down** - The interface has been deactivated.
- **vpn-up** - A VPN connection has been activated.
- **vpn-down** - A VPN connection has been deactivated.
- **hostname** - The system hostname has been updated. Use gethostname(2) to
  retrieve it.
- **dhcp4-change** - The DHCPv4 lease has changed (renewed, rebound, etc).
- **dhcp6-change** - The DHCPv6 lease has changed (renewed, rebound, etc).

So basically without manually detecting change in network events we may use the
tool that was created just for this particular goal.
