FROM registry.fedoraproject.org/fedora-minimal:31 AS blog_content
LABEL author="Maciej Lasyk <maciek@lasyk.info>"

RUN microdnf -y install python3-pip gcc make libxslt-devel redhat-rpm-config \
    python3-devel langpacks-pl python3-lxml libxml2-devel libtiff-devel \
    libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel \
    tk-devel
COPY pelican/requirements.txt /srv/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /srv/requirements.txt

COPY pelican /srv/pelican
ENV PYTHONPATH /srv/pelican
RUN [ "/usr/local/bin/pelican", "/srv/pelican/content", "-o", "/srv/pelican/output", "-s", "/srv/pelican/publishconf.py" ]

FROM registry.fedoraproject.org/fedora-minimal:31 AS webserver
RUN microdnf -y install lighttpd
COPY --from=blog_content /srv/pelican/output /var/www/lighttpd
RUN chown lighttpd:lighttpd /var/www/lighttpd -R && \
    mkdir /run/lighttpd && chown lighttpd:lighttpd /run/lighttpd

# CMD ["/bin/sleep", "900"]
CMD ["lighttpd", "-f", "/etc/lighttpd/lighttpd.conf", "-D"]