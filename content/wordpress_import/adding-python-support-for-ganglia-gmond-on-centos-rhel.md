Title: Adding Python support for Ganglia - gmond on Centos / RHEL
Date: 2013-11-10 14:40
Author: docent
Category: tech
Tags: ganglia, gmond, python, monitoring
Slug: adding-python-support-for-ganglia-gmond-on-centos-rhel
Status: published

<center>![Ganglia]({filename}/images/ganglia_logo_small.jpg)</center>

While creating Ganglia RPM packages for my Centos repository I got stuck
with a lack of Python support in Ganglia - gmond. I'll try to to explain
details of this whole issue.

First of all one could just install ganglia-gmond packages from
[Epel](https://fedoraproject.org/wiki/EPEL) repo - and that will make
the general case. I checked EPEL packages and those contain
**modpython.so** so go for it ;) But I just couldn't go that way as I
had to create my own packages.

First of all - let's check the compilation params regarding to Python:

```bash
[root@vm-2-repo ganglia-gmond-3.6.0]# ./configure --help | grep -i python
  --disable-python        exclude mod_python and support for metric modules written in python
  --with-python=PATH      Specify prefix for python or full path to interpreter
```

So by default there should be Python support builtin. But after
compiling & building there's no **modpython.so** library
on **/usr/lib64/ganglia** and that is weird. Digging deeper
in **config.log** there's:

```bash
configure:11482: checking for python
configure:11500: found /usr/bin/python
configure:11512: result: /usr/bin/python
configure:11528: checking Python version
configure:11532: result: 2.6
configure:11554: checking Python support
configure:11556: result: no
```

Hmm - that's really weird. Let's go even more deeper - now
with **configure.ac**:

```bash
AC_ARG_WITH( python,
[  --with-python=PATH      Specify prefix for python or full path to interpreter],
[if test x"$withval" != xno; then enable_python="yes"; PYTHON_BIN="$withval"; fi])

[...]

AC_ARG_ENABLE( python,
[  --disable-python        exclude mod_python and support for metric modules written
 in python],
[ if test x"$enableval" != xyes; then enable_python="no"; fi ], [ enable_python="yes" ] )
```

Ok so it's true - by default there should be Python support. Let's check
further (still **configure.ac**):

```bash
if test x"$enable_python" = xyes; then
  echo
  echo Checking for python

  # check for Python executable
  if test -z "$PYTHON_BIN"; then
    AC_PATH_PROG(PYTHON_BIN, python)
  else
    if test -d "$PYTHON_BIN"; then
      PYTHON_BIN="$PYTHON_BIN/bin/python"
    fi
  fi

  if test -n "$PYTHON_BIN"; then
    # find out python version
    AC_MSG_CHECKING(Python version)
    PyVERSION=`$PYTHON_BIN -c ['import sys; print sys.version[:3]'`]
    PyMAJVERSION=`$PYTHON_BIN -c ['import sys; print sys.version[:1]'`]
    AC_MSG_RESULT($PyVERSION)
    PYTHON_VERSION=$PyVERSION
    AC_SUBST(PYTHON_VERSION)

    PyEXEC_INSTALLDIR=`$PYTHON_BIN -c "import sys; print sys.exec_prefix"`
    if test -f "$PyEXEC_INSTALLDIR/include/python/Python.h"; then
      PYTHON_INCLUDES="-I$PyEXEC_INSTALLDIR/include/python"
    else
      if test -f "$PyEXEC_INSTALLDIR/include/python$PyVERSION/Python.h"; then
        PYTHON_INCLUDES="-I$PyEXEC_INSTALLDIR/include/python$PyVERSION"
      else
        PYTHON_INCLUDES=""
        enable_python="no"
      fi
    fi
    AC_SUBST(PYTHON_INCLUDES)
  else
    enable_python="no"
  fi
fi
```

Ah crap - and here it is. Python support will be disabled and
modpython.so library won't be created when there's no header files for
Python on our OS. You can make sure if there is **Python.h by using
locate / find / whatever.**

Solution? Just:

```bash
yum install python-devel
```

And that will make
it.
