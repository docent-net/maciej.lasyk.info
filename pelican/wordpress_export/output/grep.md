Title: Grep
Date: 2014-02-18 23:19
Author: docent
Category: tech
Tags: grep
Slug: Grep
Status: published

<!--:en-->

[![GREP](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/02/Screenshot-from-2014-02-19-001440-201x300.png){.aligncenter
.size-medium .wp-image-480 width="201"
height="300"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/02/Screenshot-from-2014-02-19-001440.png)

This is crazy. grep 2.17 is out and has a lot of improvements. "a lot"
means here:

``` {.theme:eclipse .lang:default .decode:true}
grep -i in a multibyte locale is now typically 10 times faster
for patterns that do not contain \ or [.

grep (without -i) in a multibyte locale is now up to 7 times faster
when processing many matched lines.
```

And my poor Fedora 20 has only grep 2.6.3. It's time to build packages.

Read more
at <http://thread.gmane.org/gmane.comp.gnu.grep.bugs/5154><!--:--><!--:pl-->[![GREP](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/02/Screenshot-from-2014-02-19-001440-201x300.png){.aligncenter
width="201"
height="300"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2014/02/Screenshot-from-2014-02-19-001440.png)

This is crazy. grep 2.17 is out and has a lot of improvements. "a lot"
means here:

    grep -i in a multibyte locale is now typically 10 times faster
    for patterns that do not contain \ or [.

    grep (without -i) in a multibyte locale is now up to 7 times faster
    when processing many matched lines.

And my poor Fedora 20 has only grep 2.6.3. It's time to build packages.

Read more
at <http://thread.gmane.org/gmane.comp.gnu.grep.bugs/5154><!--:-->
