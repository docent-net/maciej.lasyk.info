Title: Wordpress plugin Random Posts Widget Configurable is misbehaving
Date: 2013-05-11 19:40
Author: docent
Category: tech
Tags: wordpress
Slug: wordpress-plugin-random-posts-widget-configurable-is-misbehaving
Status: published

<!--:en-->I was looking for some WP plugin that generates widget with a
list of random posts in the sidebar. First hit was [Random Posts Widget
Configurable](http://wordpress.org/extend/plugins/random-posts-widget-configurable/) -
so I downloaded and installed it. Works fine - but there was some border
I didn't like to decided so remove it. While lurking into the code I
spotted this one:[  
](http://wordpress.org/extend/plugins/random-posts-widget-configurable/)

``` {.lang:php .decode:true}
if (rand(0, 70)==1 && !is_user_logged_in() && $bloglan==’de-DE’) {
echo ‘
<div id="”post-randomlink”">
<ul>
    <li><a href="”http://www.kleiderweb.com/online/primark-deutschland-gunstige-kleider-online/”">primark</a></li>
</ul>
</div>
’;
}
```

Seriously? Some shop AD? There is already some posts about it on WP
site: <http://wordpress.org/support/view/plugin-reviews/random-posts-widget-configurable>

So - remember to check the code of plugins You use. I'll try to write a
post about Wordpress security - It could be helpful for some of
You.<!--:--><!--:pl-->Szukałem jakiegoś plugina do Wordpressa
generującego widget do wyświetlania randomowych postów w sidebarze.
Pierwszy hit w Google: [Random Posts Widget
Configurable](http://wordpress.org/extend/plugins/random-posts-widget-configurable/) -
ściągnąłem i zainstalowałem. Jednak - coś mi się nie podobało (ramka),
więc zdecydowałem się ją usunąć. Zaglądając do kodu zauważyłem takie
coś:[  
](http://wordpress.org/extend/plugins/random-posts-widget-configurable/)

``` {.lang:php .decode:true .crayon-selected}
if (rand(0, 70)==1 && !is_user_logged_in() && $bloglan==’de-DE’) {
echo ‘
<div id="”post-randomlink”">
<ul>
    <li><a href="”http://www.kleiderweb.com/online/primark-deutschland-gunstige-kleider-online/”">primark</a></li>
</ul>
</div>
’;
}
```

Poważnie? Reklama sklepu..? Na forum plugina jest już na ten temat
wzmianka: <http://wordpress.org/support/view/plugin-reviews/random-posts-widget-configurable>

Pamiętajcie - patrzcie w kod pluginów, których używacie. Niebawem
napiszę post na temat zabezpieczania instalacji Wordpressa - w sumie to
się może niektórym z Was okazać pomocne.<!--:-->
