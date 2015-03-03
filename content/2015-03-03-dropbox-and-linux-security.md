Title: Dropbox and security of your files in Linux
Category: tech
Tags: dropbox,security
Author: Maciej Lasyk
Summary: Is Dropox secure for you?

<center>![RHEL]({filename}/images/dropbpx-logo.png)</center>

### WAT? ###

So there's been discussion about [Dropbox indexing all files on Windows
boxes](http://www.e-siber.com/guvenlik/dropbox-accesses-all-the-files-in-your-pc-not-just-sync-folder-and-steals-everything/)

It basically tells that Dropbox scans all the files in the whole drive:

> Dropbox syncs not only its own folder but also everything in local drive (C:)
> without any user consent or permission.

<center>![WAT]({filename}/images/wat.jpg)</center>

### How about Linux? ###

First of all - if you're sane Linux user than you use one of the [Linux
Security Modules (LSMs)](https://en.wikipedia.org/wiki/Linux_Security_Modules)
and literally don't give a fuck. Even when [Steam wants to delete all your files
in
hard-drive](http://www.techrepublic.com/article/moving-steams-local-folder-deletes-all-user-files-on-linux/)
you show him a middle finger and praise [Dan Walsh for his
work](http://danwalsh.livejournal.com/)

I'll tell this one more time - use SELinux. [Read this
book](https://www.packtpub.com/networking-and-servers/selinux-system-administration)
- it's only 100 pages for the sake. Or use AppArmor if SELinux is too hard for
you. Then you will never find yourself again in such hard position.

### Erm.. Linux again? ###

Ok, let's say you don't use SELinux (because if you did you wouldn't have to
read this).

So I run Dropbox (default datadir in ~/Dropbox) and fetched its PID and attached strace:

```bash
strace -f -e trace=file -s 1024 -p 6033 -o ~/tmp/dropbox-wtf.txt
```

Now I tried to create a file outside of ~/Dropbox directory:

```bash
touch ~/tmp/wtf.txt
```

... and ...

**N O T H I N G**

**Quiet**

**Peace**

Later on just to confirm I created a file in ~/Dropbox/tmp and got a ton of
crap from the strace - filtered out the ENOENT so it's more clear (nothing
interesting there):

```bash
6308  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6308  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 35
6308  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6308  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 35
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 48
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOATIME) = 35
6294  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 35
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY) = 35
6294  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 47
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOATIME) = 47
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOATIME) = 35
6294  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 47
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt/.dropbox.attr", O_RDONLY|O_NOCTTY) = -1 ENOTDIR (Not a directory)
6294  lstat("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", {st_mode=S_IFREG|0664, st_size=4, ...}) = 0
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_NOATIME) = 35
6294  open("/home/putinstopattackingukraine/Dropbox/tmp/wtf.txt", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOATIME) = 35
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/filecache.dbx", {st_mode=S_IFREG|0644, st_size=26258432, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/filecache.dbx-journal", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 48
6294  stat("/var/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
6294  access("/var/tmp", R_OK|W_OK|X_OK) = 0
6294  open("/var/tmp/etilqs_1GCo6ezszP3OnQ1", O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC, 0600) = 52
6294  unlink("/var/tmp/etilqs_1GCo6ezszP3OnQ1") = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1", O_RDONLY|O_CLOEXEC) = 54
6294  unlink("/home/putinstopattackingukraine/.dropbox/instance1/filecache.dbx-journal") = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 35
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
6294  open("/dev/urandom", O_RDONLY)    = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  open("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", O_RDWR|O_CREAT|O_CLOEXEC, 0644) = 47
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/UPDATED_jt6wdD", {st_mode=S_IFREG|0600, st_size=7168, ...}) = 0
6294  stat("/home/putinstopattackingukraine/.dropbox/instance1/PENDING_FIbd69", {st_mode=S_IFREG|0600, st_size=5120, ...}) = 0
```
So we basically see that Dropbox reads only its datadir (~/Dropbox), config dir
(~/.dropbox), urandom device (probably generating bitcoins, but this is ok),
and /var/tmp (not sure however what kind of tmpfiles it creates - but this
would be rather performance question).

So we're safe. Dropbox does not read all the file contents on Linux.

**But once again - start using Linux Security Modules!**

