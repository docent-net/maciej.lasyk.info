#!/bin/bash
yum install -y nginx
gsutil cp gs://ml-maciej-lasyk-info/ml-nginx_health_check.conf /etc/nginx/default.d/health_check.conf
systemctl enable --now nginx