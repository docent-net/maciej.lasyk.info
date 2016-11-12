Title: Moving Wordpress admin panel to another TCP port (with SSL)
Date: 2013-12-29 17:05
Author: docent
Category: tech
Tags: port, ssl, tcp, wordpress
Slug: moving-wordpress-admin-panel-to-another-tcp-port-with-ssl
Status: published

<!--:en-->

[![Wordpress
logo](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/wordpress-logo-stacked-rgb-300x186.png){.aligncenter
.wp-image-446 width="180"
height="112"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/wordpress-logo-stacked-rgb.png)

Last time I've been working on my Wordpress installation security. I
added a few layers of high-level-security-paranoia. One of those was
moving admin-panel to another TCP port (this was because I got only 1
public IP addr on this VPS and that means only one SSL legit certificate
on 443 port. So - each SSL webservice on my server is now binded to a
different TCP port and those are 'SSL green' ;) ).

Running admin panel over SSL is a thing which has already been described
on a many websites:

-   <span
    style="line-height: 12.997159004211426px;"><http://codex.wordpress.org/Administration_Over_SSL>  
   </span>
-   http://www.wpbeginner.com/wp-tutorials/how-to-secure-your-wordpress-pages-with-ssl/
-   http://support.godaddy.com/help/article/6922/using-an-ssl-with-your-wordpress-admin-control-panel

But I haven't found any article about running Admin Panel over SSL on
different port than the website. So I took a deep dive (oh not that
deep) into Wordpress code and found, that it's really that simple ;)
Assuming my admin panel is running on TCP/445 port and website is as
usual on TCP/80 all i had to do was this chunk of PHP code (maybe not
that clean, but it's just working fine) - put it in **wp-config.php**
file:

``` {.lang:php .decode:true}
if(isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' && isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT']==445)
{   
    define('WP_HOME','https://maciek.lasyk.info:445/sysop');
    define('WP_SITEURL','https://maciek.lasyk.info:445/sysop');
}
```

References:

-   <span
    style="line-height: 12.997159004211426px;"><http://codex.wordpress.org/Changing_The_Site_URL>  
   </span>

<!--:--><!--:pl-->

-   [![Wordpress
    logo](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/wordpress-logo-stacked-rgb-300x186.png){.aligncenter
    width="180"
    height="112"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/12/wordpress-logo-stacked-rgb.png)Last
    time I've been working on my Wordpress installation security. I
    added a few layers of high-level-security-paranoia. One of those was
    moving admin-panel to another TCP port (this was because I got only
    1 public IP addr on this VPS and that means only one SSL legit
    certificate on 443 port. So - each SSL webservice on my server is
    now binded to a different TCP port and those are 'SSL green' ;) ).

    Running admin panel over SSL is a thing which has already been
    described on a many websites:

    -   <http://codex.wordpress.org/Administration_Over_SSL>
    -   http://www.wpbeginner.com/wp-tutorials/how-to-secure-your-wordpress-pages-with-ssl/
    -   http://support.godaddy.com/help/article/6922/using-an-ssl-with-your-wordpress-admin-control-panel

    But I haven't found any article about running Admin Panel over SSL
    on different port than the website. So I took a deep dive (oh not
    that deep) into Wordpress code and found, that it's really that
    simple ;) Assuming my admin panel is running on TCP/445 port and
    website is as usual on TCP/80 all i had to do was this chunk of PHP
    code (maybe not that clean, but it's just working fine) - put it
    in **wp-config.php** file:

        if(isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' && isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT']==445)
        {   
            define('WP_HOME','https://maciek.lasyk.info:445/sysop');
            define('WP_SITEURL','https://maciek.lasyk.info:445/sysop');
        }

    References:

    -   <http://codex.wordpress.org/Changing_The_Site_URL>

<!--:-->
