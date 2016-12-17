Title: systemd 231 in Centos 7 thx to Facebook
Category: tech
Tags: systemd, centos, facebook, fedora
Author: Maciej Lasyk
Summary: guys from FB-Engineering shared what they were talking about during systemd.conf
Slug: systemd-231-latest-in-centos-7-thx-to-facebook

<center>![systemd ftw!]({filename}/images/pid1.png)</center>

# What is it about? #

So [Centos7](https://www.centos.org/) currently has [systemd](https://www.freedesktop.org/wiki/Software/systemd/)
version 219 installed whic was released on 2015-02-16 (see [NEWS](https://github.com/systemd/systemd/blob/master/NEWS)).

This is a huge problem, as we miss a lot of very important functions related to
journald, networkd, machinectl, systemd-nspawn and so on.

Porting latest systemd versions to Centos is a daunting task. It's possible,
but it takes time. And during latest [systemd conference](https://conf.systemd.io/)
guys from [Facebook Engineering](https://twitter.com/fb_engineering) told us,
that they actually did it. [Marcin](https://twitter.com/marcinskarbek) asked
them if they're gonna share it and Davide replied, that it should be easy and
will think about it.

And they did. Yesterday.

On Facebook Incubator project on Github you'll find [rpm - backports](https://github.com/facebookincubator/rpm-backports)

And there's also a [COPR repo](https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/) 
shared by a Red-Hatter [Jan Synacek](https://github.com/jsynacek).

Having those both you may install systemd 231 on your Centos7.

It's not however meant currently to be meant as production and also doesn't
provide SELinux policies / contexts. But.. it works. And it works on FB scale 
:)

# Quick howto #

(it's copy&paste from [Jan's COPR installation instructions](https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/)
, so make sure it's up to date:

```bash
Make sure to edit /etc/selinux/config and put SELinux to permissive before you update, otherwise your system will not boot anymore!
# wget https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/repo/epel-7/jsynacek-systemd-backports-for-centos-7-epel-7.repo -O /etc/yum.repos.d/jsynacek-systemd-centos-7.repo
# yum update systemd
```
# Short story longer #

And special thanks to [Marcin Sawicki](https://twitter.com/odcinek) for 
catching my tweet and moving things forward <3

Guys - thank you a lot for this!

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Wow:<a href="https://t.co/Nh1yoxlGIG">https://t.co/Nh1yoxlGIG</a> now just waiting till <a href="https://twitter.com/fb_engineering">@fb_engineering</a> share theirs <a href="https://twitter.com/hashtag/systemd?src=hash">#systemd</a> <a href="https://twitter.com/hashtag/Fedora?src=hash">#Fedora</a> port to <a href="https://twitter.com/hashtag/centos?src=hash">#centos</a> mentioned on <a href="https://twitter.com/systemdconf">@systemdconf</a> &lt;3</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/806196636770795521">December 6, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> was it Davide announcing that? I can ping him tmorrow at the office ;)</p>&mdash; Marcin Sawicki (@odcinek) <a href="https://twitter.com/odcinek/status/809314228091785216">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/odcinek">@odcinek</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> do you remember? If not I&#39;ll search it in the videos.</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809332228723445760">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/odcinek">@odcinek</a> no, not announced. It was only an answer about possibility of releasing when we asked about this.</p>&mdash; Marcin Skarbek (@marcinskarbek) <a href="https://twitter.com/marcinskarbek/status/809334484533387264">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> <a href="https://twitter.com/odcinek">@odcinek</a> &#39;mentioned&#39; -&gt; &#39;announced&#39; -&gt; &#39;published&#39;; can we agree on that? :D</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809350242223198208">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="und" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/odcinek">@odcinek</a> <a href="https://t.co/7q1ZAXnSj7">pic.twitter.com/7q1ZAXnSj7</a></p>&mdash; Marcin Skarbek (@marcinskarbek) <a href="https://twitter.com/marcinskarbek/status/809351156375883776">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> <a href="https://twitter.com/odcinek">@odcinek</a> This is part of presentation/Q&amp;A where systemd port was mentioned: <a href="https://t.co/NziIK41PYE">https://t.co/NziIK41PYE</a> but have to dig where</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809352168725684226">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> <a href="https://twitter.com/odcinek">@odcinek</a> Davide actually told that FB will share it. My memory tells me it was somewhere inside the presentation, not Q&amp;A</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809352439266758656">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/odcinek">@odcinek</a> ok, I found it: <a href="https://t.co/gMMSqbp8vk">https://t.co/gMMSqbp8vk</a></p>&mdash; Marcin Skarbek (@marcinskarbek) <a href="https://twitter.com/marcinskarbek/status/809357830201503744">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> <a href="https://twitter.com/odcinek">@odcinek</a> great, so now fingers crossed :)</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809362164930805761">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="es" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> tada! <a href="https://t.co/yvMtY4zJSM">https://t.co/yvMtY4zJSM</a></p>&mdash; Marcin Sawicki (@odcinek) <a href="https://twitter.com/odcinek/status/809450352390991872">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/odcinek">@odcinek</a> <a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> And the copr repo from RH of these packages for CentOS 7: <a href="https://t.co/F7EmQhxOZU">https://t.co/F7EmQhxOZU</a></p>&mdash; PhilD (@ThePhilD) <a href="https://twitter.com/ThePhilD/status/809492567511310336">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/ThePhilD">@ThePhilD</a> <a href="https://twitter.com/odcinek">@odcinek</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> sweet, many thanks! Next question was about <a href="https://twitter.com/hashtag/SELinux?src=hash">#SELinux</a>, but I see it&#39;s like work in progress ;) Thanks!</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809494964958883840">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="und" dir="ltr"><a href="https://twitter.com/docent_net">@docent_net</a> <a href="https://twitter.com/ThePhilD">@ThePhilD</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> <a href="https://t.co/vLALC4IUZT">pic.twitter.com/vLALC4IUZT</a></p>&mdash; Marcin Sawicki (@odcinek) <a href="https://twitter.com/odcinek/status/809513208998309888">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/odcinek">@odcinek</a> <a href="https://twitter.com/ThePhilD">@ThePhilD</a> <a href="https://twitter.com/marcinskarbek">@marcinskarbek</a> booring :p</p>&mdash; Maciek Lasyk (@docent_net) <a href="https://twitter.com/docent_net/status/809515640193220608">December 15, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>