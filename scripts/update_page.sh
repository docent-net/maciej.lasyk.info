#!/bin/bash

# this is taken from env variable set in /etc/profile.d/webpage.sh
REPO_DIR=${WEBPAGE_PATH}

sudo git -C ${REPO_DIR} pull
sudo -- sh -c "cd ${REPO_DIR}/pelican; pwd; pelican ${REPO_DIR}/pelican/content -o ${REPO_DIR}/output -s ${REPO_DIR}/pelican/publishconf.py" 
