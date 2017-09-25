#!/bin/bash
yum install -y docker git
systemctl enable --now docker
gcloud docker -- pull gcr.io/maciej-lasyk-info/nginx-f26.1:latest
gcloud docker -- pull gcr.io/maciej-lasyk-info/pelican-f25.1:latest
git clone https://github.com/docent-net/maciej.lasyk.info.git /srv/maciej.lasyk.info

sh /srv/maciej.lasyk.info/terraform/scripts/ml-update-blog.sh

docker run -d -p 80:80 --name nginx \
    -v /srv/maciej.lasyk.info/terraform/templates/nginx_health_check.conf:/etc/nginx/default.d/health_check.conf:Z \
    -v /srv/maciej.lasyk.info/terraform/templates/maciej.lasyk.info.conf:/etc/nginx/default.d/maciej.lasyk.info.conf:Z \
    -v /srv/maciej.lasyk.info/output:/srv/www:Z \
    gcr.io/maciej-lasyk-info/nginx-f26.1