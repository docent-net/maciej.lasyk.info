Title: Gmail like "+" adresses aliases in Postfix
Date: 2013-12-27 22:47
Author: docent
Category: postfix
Tags: aliases, gmail, pcre, postfix, regexp
Slug: gmail-like-adresses-aliases-in-postfix
Status: published

<!--:en-->

[![Gmail
logo](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/Gmail_logo.png){.aligncenter
.wp-image-443 width="266"
height="120"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/Gmail_logo.png)

A few weeks ago I completely migrated from Gmail to my own e-mail
solution (based on Postfix, Dovecot, RoundCube and some evil security
layers). One of the important things about managing you own email server
is saving your time. So when tweaking - you should do it simple and
fast.

I really missed one simple trick from Gmail - those aliases created
dynamically with the use of plus character (e.g. maciej+spam@lasyk.info
- you'll find more
here: <https://support.google.com/mail/answer/12096?hl=en>).

Of course - one could simply create some aliases in /etc/aliases or even
in virtual\_maps for particular domains but we have to save our time and
we should find some way that it could be done without our intervention
anytime we'd like to create new alias.

It's really simple. just use PCRE tables (or regex - whatever). I used
PCRE (<http://www.postfix.org/pcre_table.5.html>) - and added just one
line there:

``` {.lang:default .decode:true}
/^maciek\+.+?@lasyk\.info$/          user
```

As PCREs are greedy by default I used the lazy quantifier "?" before the
'@'. And now I can enjoy what I used back in Gmail epoch
;)<!--:--><!--:pl-->[![Gmail
logo](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/Gmail_logo.png){width="266"
height="120"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/Gmail_logo.png)

 

A few weeks ago I completely migrated from Gmail to my own e-mail
solution (based on Postfix, Dovecot, RoundCube and some evil security
layers). One of the important things about managing you own email server
is saving your time. So when tweaking - you should do it simple and
fast.

I really missed one simple trick from Gmail - those aliases created
dynamically with the use of plus character (e.g. maciej+spam@lasyk.info
- you'll find more
here: <https://support.google.com/mail/answer/12096?hl=en>).

Of course - one could simply create some aliases in /etc/aliases or even
in virtual\_maps for particular domains but we have to save our time and
we should find some way that it could be done without our intervention
anytime we'd like to create new alias.

It's really simple. just use PCRE tables (or regex - whatever). I used
PCRE (<http://www.postfix.org/pcre_table.5.html>) - and added just one
line there:

    /^maciek\+.+?@lasyk\.info$/          user

As PCREs are greedy by default I used the lazy quantifier "?" before the
'@'. And now I can enjoy what I used back in Gmail epoch ;)<!--:-->
