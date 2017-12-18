#!/bin/bash
GIT=/usr/bin/git
export PROJDIR=/srv/dlugodystansowy.pl

$GIT clone https://github.com/docent-net/dlugodystansowy.pl.git ${PROJDIR}
cd ${PROJDIR}
$GIT fetch --all
$GIT reset --hard origin/master
docker rm pelican-dlugodystansowy.pl &> /dev/null
docker run --name pelican-dlugodystansowy.pl -v ${PROJDIR}/pelican/content:/srv/content:Z \
    -v ${PROJDIR}/pelican/output:/srv/output:Z \
    -v ${PROJDIR}/pelican/pelicanconf.py:/srv/pelicanconf.py:Z \
    -v ${PROJDIR}/pelican/publishconf.py:/srv/publishconf.py:Z \
    -v ${PROJDIR}/pelican/themes:/srv/themes:Z \
    -v ${PROJDIR}/pelican/plugins:/srv/plugins:Z gcr.io/maciej-lasyk-info/pelican-f25.1