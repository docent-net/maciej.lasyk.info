#!/bin/bash
GIT=/usr/bin/git

export PROJDIR=/srv/maciej.lasyk.info
cd ${PROJDIR}
$GIT fetch --all
$GIT reset --hard origin/master
docker rm pelican-sport &> /dev/null
docker run --name pelican-sport -v ${PROJDIR}/pelican-sport/content:/srv/content:Z \
    -v ${PROJDIR}/pelican-sport/output:/srv/output:Z \
    -v ${PROJDIR}/pelican-sport/pelicanconf.py:/srv/pelicanconf.py:Z \
    -v ${PROJDIR}/pelican-sport/publishconf.py:/srv/publishconf.py:Z \
    -v ${PROJDIR}/pelican-sport/themes:/srv/themes:Z \
    -v ${PROJDIR}/pelican-sport/plugins:/srv/plugins:Z gcr.io/maciej-lasyk-info/pelican-f25.1
