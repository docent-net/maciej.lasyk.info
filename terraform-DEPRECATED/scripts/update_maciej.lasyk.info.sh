#!/bin/bash
GIT=/usr/bin/git
export PROJDIR=/srv/maciej.lasyk.info

cd ${PROJDIR}
$GIT fetch --all
$GIT reset --hard origin/master
gcloud docker -- pull gcr.io/maciej-lasyk-info/pelican-f26-2
docker rm pelican &> /dev/null
docker run --name pelican -v ${PROJDIR}/pelican/content:/srv/content:Z \
    -v ${PROJDIR}/pelican/output:/srv/output:Z \
    -v ${PROJDIR}/pelican/pelicanconf.py:/srv/pelicanconf.py:Z \
    -v ${PROJDIR}/pelican/publishconf.py:/srv/publishconf.py:Z \
    -v ${PROJDIR}/pelican/themes:/srv/themes:Z \
    -v ${PROJDIR}/pelican/plugins:/srv/plugins:Z gcr.io/maciej-lasyk-info/pelican-f26-2
