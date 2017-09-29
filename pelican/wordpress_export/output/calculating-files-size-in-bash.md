Title: Calculating files size in bash
Date: 2011-12-09 09:31
Author: docent
Category: tech
Tags: bash, oneliner
Slug: calculating-files-size-in-bash
Status: published

<!--:en-->

When we face the problem of calculating size of some files then we often
think of **du**.. But how could we count size of files found by
**find**? We could do this with this simple one-liner:

    find /somewhere -name 'some_files*' -exec wc -c '{}' +

</code>

Find command is simple here. We use here also a POSIX solution - ending
"exec" with a plus-sign not a semicolon. This form groups the finding
results into sets and then run commands on whole that set. And that's
why we use it here - our **wc -c** command is run on a whole set of
results giving us in the end line the total size of all the files:

    [root@docent log]# find . -name 'maillog*' -exec wc -c '{}' +

     6847 ./maillog-20111120

     6137 ./maillog

     6580 ./maillog-20111204

     5028 ./maillog-20111113

     6424 ./maillog-20111127

    31016 total

</code>

We could shorten that a little:

    [root@docent log]# find . -name 'maillog*' -exec wc -c '{}' + | tail -1

    31016 total

</code>

And If we would like to have only the number:

    [root@docent log]# find . -name 'maillog*' -exec wc -c '{}' + | tail -1 | cut -d' ' -f 1

    31016

</code>

<!--:-->
