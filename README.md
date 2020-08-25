# maciej.lasyk.info #

This repo contains all content files used to generate and deploy 
[my blog](http://maciej.lasyk.info).

## Requirements ##

My blog uses [Pelican](http://blog.getpelican.com/) backend as engine. Pelican 
is a static - file generator.

Blog is deployed inside of my private, bare-metal Kubernetes cluster.

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

## Deployment ##

Blog is deployed in my private, bare-metal k8s cluster. I don't publish helm charts 
as nothing fancy is there - just Nginx server hosting static files.