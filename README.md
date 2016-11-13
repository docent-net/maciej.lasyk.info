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

## Running ##

I run this blog with [nginx](https://www.nginx.org/) run in 
[Docker](https://www.docker.com) container. Nginx serves static files 
generated by Pelican inside of another Docker container.

See [nginx.dockerfile](nginx.dockerfile) and 
[pelican.dockerfile](pelican.dockerfile) for details about building those
containers.

On my laptop I build and run containers with:

```
docker build -t pelican -f pelican.dockerfile .
# this might be also PROJDIR=`pwd` when running inside PROJECT DIR
export PROJDIR=/directory/to/blog/repo
docker run --name pelican \
    -v ${PROJDIR}/content:/srv/content:Z \
    -v ${PROJDIR}/output_docker:/srv/output:Z \
    -v ${PROJDIR}/pelicanconf.py:/srv/pelicanconf.py:Z \
    -v ${PROJDIR}/themes:/srv/themes:Z \
    -v ${PROJDIR}/plugins:/srv/plugins:Z \
    pelican
```

Above command creates container that generates all static files and saves
them to **output_docker** directory. Take notice of all volumes that are
attached to this container. Also keep in mind that I use **SELinux** in 
enforcing mode - that's why every volume has **:Z** added in order to have
proper context defined on mounted files by SELinux.

Next simply build and run Nginx container (just make sure you configure nginx
to use /srv/www as root directory):

```
docker build -t nginx -f nginx.dockerfile .
export PROJDIR=/directory/to/blog/repo; docker run -d --name nginx -p 8001:80 \
    -v ${PROJDIR}/output_docker:/srv/www:Z nginx
```
