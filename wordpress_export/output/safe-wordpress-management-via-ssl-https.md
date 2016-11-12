Title: Safe Wordpress management via SSL / HTTPS
Date: 2012-09-17 21:11
Author: docent
Category: Uncategorized
Tags: ssl, wordpress
Slug: safe-wordpress-management-via-ssl-https
Status: published

<!--:en-->Why would You like to secure Your wp-admin session with SSL?
Remember - Big Brother is always watching - so don't make his life easy.

In order to use SSL in wp-admin the morst important thing is to enable
SSL in WWW server's vhost (eg. Apache). When SSL is turned on for Your
Wordpress domain it will work just out of the box.

So what is also important here? You should always make users use SSL in
wp-admin sessions. So make it obligatory. You can do it using
mod\_rewrite in Apache webserver (**httpd.conf** or **.htaccess**):

> RewriteEngine On  
> RewriteBase /  
> RewriteCond %{HTTPS} !=on  
> RewriteRule "\^(/wp-admin/.\*)" "https://%{HTTP\_HOST}\$1" \[R=301,L\]

Or simplier - editing Your **wp-config.php** file - add below line**:**

> define('FORCE\_SSL\_ADMIN', true);

somewhere before the folliwing line:

> require\_once(ABSPATH . 'wp-settings.php');

And that should do the trick!<!--:--><!--:pl-->Nie będę może wspominał
dlaczego należy zabezpieczać sesje administracyjne dowolnych usług
webowych (i nie tylko webowych..). Pamiętaj - wielki brat patrzy, więc
nie pozwalajmy na to aby wszystko co robimy było łatwe do przechwycenia.

Samo zabezpieczenie SSLem Wordpressa jest dość proste - sprowadza się do
uruchomienia obsługi SSL dla wybranego vhosta w serwerze WWW (np.
Apache). Sam Wordpress pod SSLem powinien zadziałać z miejsca - bez
żadnej dodatkowej konfiguracji.

Jednakże - istotne jest, aby SSLa wymusić. Sposobów jest kilka - możemy
użyć mod\_rewrite dla strony nie SSLowej i przekierować ją na SSL w
przypadku gdy użytkownik używa skryptów w katalogu wp-admin (httpd.conf
bądź .htaccess):

> RewriteEngine On  
> RewriteBase /  
> RewriteCond %{HTTPS} !=on  
> RewriteRule "\^(/wp-admin/.\*)" "https://%{HTTP\_HOST}\$1" \[R=301,L\]

Lub prościej - edytując **wp-config.php** - dodajemy wpis**:**

> define('FORCE\_SSL\_ADMIN', true);

gdzieś przed:

> require\_once(ABSPATH . 'wp-settings.php');

Tyle powinno wystarczyć..<!--:-->
