Title: Lighttpd expire.url mixed entries
Date: 2012-07-05 14:46
Author: docent
Category: configuration
Tags: lighttpd
Slug: lighttpd-expire-url-mixed-entries
Status: published

<!--:en-->Lately I had to set expiration settings for some webcontent in
whole virtual host in Lighttpd. So i set:

    expire.url = ( "" => "access 3 months" )

And tested if it's working fine:

    [root@centos62-minimal ~]# wget -S --header="Host: test" "http://192.168.122.245:85/test.css" --2012-07-05 16:32:05-- http://192.168.122.245:85/test.css Connecting to 192.168.122.245:85... connected. HTTP request sent, awaiting response... HTTP/1.0 200 OK Expires: Mon, 03 Oct 2012 14:32:05 GMT Cache-Control: max-age=5184000 Content-Type: text/css Accept-Ranges: bytes ETag: "1677" Last-Modified: Thu, 05 Jul 2012 14:24:50 GMT Content-Length: 5 Connection: close Date: Thu, 05 Jul 2012 14:32:05 GMT Server: lighttpd/1.4.30 Length: 5 [text/css]

So it looks fine (expiration is 3 months in future). Now I wanted to
change expiration setting for a particular subdirectory **dirtest**:

    expire.url = ( "" => "access 3 months" , "/dirtest/" => "access 5 minutes" )

 

And I found it's not working:

    [root@centos62-minimal ~]# wget -S --header="Host: test" "http://192.168.122.245:85/dirtest/test.js" --2012-07-05 16:32:05-- http://192.168.122.245:85/dirtest/test.js Connecting to 192.168.122.245:85... connected. HTTP request sent, awaiting response... HTTP/1.0 200 OK Expires: Mon, 03 Oct 2012 14:32:05 GMT Cache-Control: max-age=5184000 Content-Type: text/css Accept-Ranges: bytes ETag: "1677" Last-Modified: Thu, 05 Jul 2012 14:24:50 GMT Content-Length: 5 Connection: close Date: Thu, 05 Jul 2012 14:32:05 GMT Server: lighttpd/1.4.30 Length: 5 [text/css]

So WTF? It appears that it makes a difference in what order You've put
the entries in the conf. This one is working fine:

    expire.url = ( "/dirtest/" => "access 5 minutes" , "" => "access 3 months" )

 

    [root@centos62-minimal ~]# wget -S --header="Host: test" "http://192.168.122.245:85/dirtest/test.js" --2012-07-05 16:32:09-- http://192.168.122.245:85/dirtest/test.js" Connecting to 192.168.122.245:85... connected. HTTP request sent, awaiting response... HTTP/1.0 200 OK Expires: Thu, 05 Jul 2012 14:34:09 GMT Cache-Control: max-age=120 Content-Type: text/javascript Accept-Ranges: bytes ETag: "3840495965" Last-Modified: Thu, 05 Jul 2012 14:27:37 GMT Content-Length: 3 Connection: close Date: Thu, 05 Jul 2012 14:32:09 GMT Server: lighttpd/1.4.30 Length: 3 [text/javascript]

So just remember about proper ordering of items in **expire.url** entry
:)

(tested on **lighttpd-1.4.30**)<!--:-->
