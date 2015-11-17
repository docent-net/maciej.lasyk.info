Title: Cheap SSD arrays for Continuous Integration
Category: tech
Tags: hardware,raid,ssd,array,matrix
Author: Maciej Lasyk
Summary: Building cheap SSD arrays for DevOps purposes

<center>![Its me!]({filename}/images/ssd_array.jpg)</center>

### The need for iop/s ###

I think that every sysdamin has this need. It is like "I have a need - the need
for speed". So basically when I see 400 operations per second as upper limit on
some SATA drives the I cry very loudly.

But bussiness can't always provide RAID10 array of 4x240GB Intel SSD drives /
$4000.

I faced this problem lately. While improving environment performance for continuous integration I noticed how drastically we have this need for iop/s on every Jenkins and Selenium nodes.

So we have this bleeding-edge-storage which has couple of enterprise class SSDs
but honestly I didn't want to sacrifice those holy part of our infrastructure
for some ephemeral work.

I just wanted some drives which would provide me w/about 15-20k iop/s. Simple,
cheap SSD drives.

So I found, that our servers actually have a free drive slots inside. Unused.
Just waiting to be fulfilled with something. Think local storage :D

And this was it. What about buying desktop - class SSD drives?

### Trim issue? ###

It is not an issue. Just make sure you've got [fstrim
running](https://turriebuntu.wordpress.com/ubuntu-pages/precise-specific-pages/using-fstrim-to-trim-your-ssd-instead-of-delete-in-fstab/)
and remember to [trim on all filesystem
layers(!)](http://blog.neutrino.es/2013/howto-properly-activate-trim-for-your-ssd-on-linux-fstrim-lvm-and-dmcrypt/)

### So... what kind of drives? ###

[According to
this](http://techreport.com/review/27909/the-ssd-endurance-experiment-theyre-all-dead)
The best price to longevity ratio will give you Kingston HyperX drives ($100
each 240GB drive). So basically you can set up RAID1 for $200 or RAID10 for
$400.

Of course this is just for some temporary data. Those kind of arrays should't
be there for crucial datastores. And of course - remember about capacity
planning. When I see 600TB written as the moment in time when the drive will be
dead I can basically say, that $200 RAID array will need to be replaced in 18
months. Wow - this is really nice lifetime for this at this price. So I actualy
created 2xRAID10 arrays (240GB Kingston HyperX drives) what gave me 2x0,5TB in
RAID10 / local storage for $1000. And I'm gonna replace this in about 1,5 year
(maybe still as a subject of warranty).

Great deal imo. If I did want to but enterprise class disks (like Intel) for
this purpose I would have to pay 8\*$1000 and that is a horrible amount of
goldies.

Summing this up - CI (Jenkins, Selenium, others) + local storage on cheap SSD drives = <3
