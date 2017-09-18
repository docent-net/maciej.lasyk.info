#!/bin/bash
GIT=/usr/bin/git

cd /srv/docker_mounts/nginx/public_html/maciej.lasyk.info/
$GIT fetch --all
$GIT reset --hard netrunner/master
docker start pelican
