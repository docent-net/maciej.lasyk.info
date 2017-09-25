#!/bin/bash
GIT=/usr/bin/git

export PROJDIR=/srv/maciej.lasyk.info
cd ${PROJDIR}
$GIT fetch --all
$GIT reset --hard origin/master
docker rm pelican &> /dev/null
docker run --name pelican -v ${PROJDIR}/content:/srv/content:Z \
    -v ${PROJDIR}/output:/srv/output:Z \
    -v ${PROJDIR}/pelicanconf.py:/srv/pelicanconf.py:Z \
    -v ${PROJDIR}/publishconf.py:/srv/publishconf.py:Z \
    -v ${PROJDIR}/themes:/srv/themes:Z \
    -v ${PROJDIR}/plugins:/srv/plugins:Z gcr.io/maciej-lasyk-info/pelican-f25.1
