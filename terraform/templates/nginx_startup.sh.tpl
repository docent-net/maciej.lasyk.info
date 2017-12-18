#!/bin/bash
yum install -y docker git
systemctl enable --now docker
gcloud docker -- pull gcr.io/maciej-lasyk-info/nginx-f26.1:latest
gcloud docker -- pull gcr.io/maciej-lasyk-info/pelican-f25.1:latest

sh /srv/maciej.lasyk.info/terraform/scripts/update_maciej.lasyk.info.sh
sh /srv/maciej.lasyk.info/terraform/scripts/update_dlugodystansowy.pl.sh

docker run -d -p 80:80 --name nginx \
    -v /srv/maciej.lasyk.info/terraform/templates/nginx_health_check.conf:/etc/nginx/default.d/health_check.conf:Z \
    -v /srv/maciej.lasyk.info/terraform/templates/maciej.lasyk.info.conf:/etc/nginx/conf.d/maciej.lasyk.info.conf:Z \
    -v /srv/maciej.lasyk.info/terraform/templates/dlugodystansowy.pl.conf:/etc/nginx/conf.d/dlugodystansowy.pl.conf:Z \
    -v /srv/maciej.lasyk.info/pelican/output:/srv/www/maciej.lasyk.info:Z \
    -v /srv/dlugodystansowy.pl/pelican/output:/srv/www/dlugodystansowy.pl:Z \
    gcr.io/maciej-lasyk-info/nginx-f26.1