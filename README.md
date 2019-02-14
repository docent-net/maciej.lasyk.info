# maciej.lasyk.info #

This repo contains all content files used to generate and deploy 
[my blog](http://maciej.lasyk.info).

## Requirements ##

My blog uses [Pelican](http://blog.getpelican.com/) backend as engine. Pelican 
is a static - file generator.

Blog is deployed on **Google Cloud Platform** using [Terraform](https://www.terraform.io).

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

## Running ##

Whole deployment model is described in Terraform files. Simply read those
and run in order to deploy:

    1. `cd terraform`
    1. `terraform apply`
    
## AppEngine Image updater ##

So the ideas is about fully automated process of updating Compute Engine cloud 
images used on this blog. As blog uses stock centos images all we need to do is
replacing instances with new ones as new instances have updates libraries.

GCP Instance managers has ability to rolling replace instances. We just need a 
trigger. And for that purposes we use AppEngine which provides a cron-like 
scheduler. The only application feature is to invoke API request to the 
instance manager endpoint. 

## Running on bare-metal VMs under systemd-nspawn

This is actual way I'm running this blog (moved away from Google Cloud). 
However the deployment automation code is still not published.