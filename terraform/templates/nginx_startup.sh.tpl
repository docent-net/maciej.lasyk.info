#!/bin/bash
yum install -y docker git
systemctl enable --now docker
gcloud docker -- pull gcr.io/maciej-lasyk-info/nginx-f26.1:latest
gcloud docker -- pull gcr.io/maciej-lasyk-info/pelican-f25.1:latest

git clone https://github.com/docent-net/maciej.lasyk.info.git /srv/maciej.lasyk.info

sh /srv/maciej.lasyk.info/terraform/scripts/update_maciej.lasyk.info.sh

SSL_CERTS_DIR=/srv/maciej.lasyk.info/ssl_certs
mkdir ${SSL_CERTS_DIR}
gsutil cp gs://ml-maciej-lasyk-info/ssl_certs/privkey.pem ${SSL_CERTS_DIR}/privkey.pem
gsutil cp gs://ml-maciej-lasyk-info/ssl_certs/fullchain.pem ${SSL_CERTS_DIR}/fullchain.pem

docker run -d -p 80:80 -p 443:443 --name nginx \
    -v /srv/maciej.lasyk.info/terraform/templates/nginx_health_check.conf:/etc/nginx/default.d/health_check.conf:Z \
    -v /srv/maciej.lasyk.info/terraform/templates/maciej.lasyk.info.conf:/etc/nginx/conf.d/maciej.lasyk.info.conf:Z \
    -v /srv/maciej.lasyk.info/ssl_certs/fullchain.pem:/etc/nginx/ssl/fullchain.pem:Z \
    -v /srv/maciej.lasyk.info/ssl_certs/privkey.pem:/etc/nginx/ssl/privkey.pem:Z \
    -v /srv/maciej.lasyk.info/pelican/output:/srv/www/maciej.lasyk.info:Z \
    gcr.io/maciej-lasyk-info/nginx-f26.1