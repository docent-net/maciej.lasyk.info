Title: Grep is Your friend
Date: 2011-12-07 22:58
Author: docent
Category: tech
Tags: bash, grep, regexp
Slug: grep-is-your-friend
Status: published

<!--:en-->**GREP** stands for Global Regular Expression Print. I think
that every sysop loves **grep**, **grepping** and anything that has
something in common with **grep** - this tool makes our lives really
easier ;) If You're not convinced than I think You're in a good place -
maybe the following text will convince You :)

<ol>
1.  **Excluding irrelevant words**: sometimes We have to grep for some
    word but We have to exclude some irrelevant string. E.g. let's grep
    for 'index.html' but let's also exclude '404' from this:

    ``` {.lang:default .decode:true}
    grep 'index.html' access.log | grep -v 404
    ```

2.  **egrep** (extended grep, same as **grep -e** or **grep --regexp=**)
    allows us to do more powerful search including regular expressions
    with metacharacters like +, ?, | and ()

    ``` {.lang:default .decode:true}
    egrep "html|cgi" access.log
    ```

3.  **Counting results** - If we just want to know the number of lines
    that matched our query - We would use:

    ``` {.lang:default .decode:true}
    grep -c 'index.html' access.log
    ```

4.  **Case Insensitive search** - by default grep is case sensitive, If
    we want to make case insensitive search than we use:

    ``` {.lang:default .decode:true}
    grep -i 'Index' access.log
    ```

5.  **Matching eXact word only** - by default grepping for **Word** will
    return lines containing **SomeWord** and
    &lt;strongwordbytheway&lt; strong=""&gt;. If We would like to find
    only those lines containing exact word **Word** We should use:

    ``` {.lang:default .decode:true}
    grep -x '404' access.log
    ```

</ol>
**grep -w** could be also useful here.

<ol>
<ol>
1.  **Matching left and right side of the word** - to search for
    instances of string matching Word in the end or start We use
    **\\&lt;** or **\\&gt;**:Below would match any word starting with
    **access**, like **access\_entry**:

    ``` {.lang:default .decode:true}
    grep '\<access'
    ```

    Below would match any word ending with **error**, like
    **general\_error**:

    ``` {.lang:default .decode:true}
    grep 'error\>'
    ```

</ol>
</ol>
1.  **Showing context results** - sometimes We would like to grep for
    some errors in logs, but we also would like to view the context of
    that log entry - e.g. grepping for '**Relay access denied**' in
    Postfix logs to see If that error is occurring with some pattern:

    ``` {.lang:default .decode:true}
    grep --context=3 'Relay access denied' maillog
    ```

2.  **zgrep** - this one would grep in the compressed gzip file - just
    like **gunzip -c flog.gz | grep Word**:

    ``` {.lang:default .decode:true}
    zgrep 'Relay access denied' maillog3.gz
    ```

3.  **Coloring matched words** - We can highlight our matched words with
    some color (check man page to see how to set exact color):

    ``` {.lang:default .decode:true}
    grep --color 'Relay access denied' maillog3.gz
    ```

    <p>
     

<!--:--><!--:pl-->**GREP** stands for Global Regular Expression Print. I
think that every sysop loves **grep**, **grepping** and anything that
has something in common with **grep** - this tool makes our lives really
easier ;) If You're not convinced than I think You're in a good place -
maybe the following text will convince You :)

1.  **Excluding irrelevant words**: sometimes We have to grep for some
    word but We have to exclude some irrelevant string. E.g. let's grep
    for 'index.html' but let's also exclude '404' from this:

        grep 'index.html' access.log | grep -v 404

2.  **egrep** (extended grep, same as **grep -e** or **grep --regexp=**)
    allows us to do more powerful search including regular expressions
    with metacharacters like +, ?, | and ()

        egrep "html|cgi" access.log

3.  **Counting results** - If we just want to know the number of lines
    that matched our query - We would use:

        grep -c 'index.html' access.log

4.  **Case Insensitive search** - by default grep is case sensitive, If
    we want to make case insensitive search than we use:

        grep -i 'Index' access.log

5.  **Matching eXact word only** - by default grepping for **Word** will
    return lines containing **SomeWord** and
    &lt;strongwordbytheway&lt; strong=""&gt;. If We would like to find
    only those lines containing exact word **Word** We should use:

        grep -x '404' access.log

**grep -w** could be also useful here.

1.  **Matching left and right side of the word** - to search for
    instances of string matching Word in the end or start We
    use **\\&lt;** or **\\&gt;**:Below would match any word starting
    with **access**, like **access\_entry**:

        grep '\<access'

    Below would match any word ending with **error**,
    like **general\_error**:

        grep 'error\>'

<!-- -->

1.  **Showing context results** - sometimes We would like to grep for
    some errors in logs, but we also would like to view the context of
    that log entry - e.g. grepping for '**Relay access denied**' in
    Postfix logs to see If that error is occurring with some pattern:

        grep --context=3 'Relay access denied' maillog

2.  **zgrep** - this one would grep in the compressed gzip file - just
    like **gunzip -c flog.gz | grep Word**:

        zgrep 'Relay access denied' maillog3.gz

3.  **Coloring matched words** - We can highlight our matched words with
    some color (check man page to see how to set exact color):

        grep --color 'Relay access denied' maillog3.gz

    <p>
     

<!--:-->
