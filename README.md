# maciej.lasyk.info #

This repo contains all content files used to generate 
[my blog](http://maciej.lasyk.info).

## Requirements ##

My blog uses [Pelican](http://blog.getpelican.com/) backend as engine. Pelican 
is a static - file generator.

## Installation & Development ##

Simply install Pelican and generate static files. Use Pelican's development
server in order to run a local development version.

I strongly suggest using [virtualenv](https://virtualenv.pypa.io/en/stable/) &
[virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) in 
order to keep Pelican's libraries isolated from your OS ones.

```
mkvirtualenv maciej.lasyk.info
pip install -r requirements.txt
```