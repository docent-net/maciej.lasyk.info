FROM fedora:24
MAINTAINER Maciej Lasyk <maciek@lasyk.info>

RUN dnf -y install python-pip gcc make libxslt-devel redhat-rpm-config \
    python-devel
COPY requirements.txt /srv/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /srv/requirements.txt
ENTRYPOINT [ "/usr/bin/pelican", "/srv/content", "-o", "/srv/output", "-s", "/srv/pelicanconf.py" ]