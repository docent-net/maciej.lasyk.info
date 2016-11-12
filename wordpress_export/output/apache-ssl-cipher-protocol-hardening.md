Title: Apache SSL cipher / protocol hardening
Date: 2013-07-01 20:17
Author: docent
Category: tech
Tags: apache, openssl, ssl, security
Slug: apache-ssl-cipher-protocol-hardening
Status: published

<!--:en-->While preparing to the RHCE exam I rechecked my standard SSL
configurations and came to conclusion, that I should probably update
my **SSLCipherSuite** value. I also updated SSLProtocol and
switched **SSLHonorCipherOrder** in the way that the server's preference
of **SSLCipherSuite** is used instead of the browser's:

``` {.lang:default .decode:true}
SSLProtocol -ALL +TLSv1
SSLHonorCipherOrder On
SSLCipherSuite RC4-SHA:HIGH:!ADH
```

As You can see I also disabled SSLv3 in the **SSLProtocol. Why? Because
even IE8 on Windows XP uses TLSv1 :) You could also enter +TLSv1.1 or
even +TLSv1.2 when using appropriate version of OpenSSL.**

Read more at <http://httpd.apache.org/docs/trunk/mod/mod_ssl.html>

After applying changes make sure that new config will pass SSL
tests <https://www.ssllabs.com/ssltest/index.html><!--:--><!--:pl-->While
preparing to the RHCE exam I rechecked my standard SSL configurations
and came to conclusion, that I should probably update
my **SSLCipherSuite** value. I also updated SSLProtocol and
switched **SSLHonorCipherOrder** in the way that the server's preference
of **SSLCipherSuite** is used instead of the browser's:

    SSLProtocol -ALL +TLSv1
    SSLHonorCipherOrder On
    SSLCipherSuite RC4-SHA:HIGH:!ADH

As You can see I also disabled SSLv3 in the **SSLProtocol. Why? Because
even IE8 on Windows XP uses TLSv1 :) You could also enter +TLSv1.1 or
even +TLSv1.2 when using appropriate version of OpenSSL.**

Read more at <http://httpd.apache.org/docs/trunk/mod/mod_ssl.html>

After applying changes make sure that new config will pass SSL
tests <https://www.ssllabs.com/ssltest/index.html><!--:-->
