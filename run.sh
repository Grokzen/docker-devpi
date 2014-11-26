#!/bin/bash
set -e
set -x

export DEVPI_SERVERDIR=/opt/devpi
export DEVPI_CLIENTDIR=/tmp/devpi-client
[[ -f $DEVPI_SERVERDIR/.serverversion ]] || initialize=yes

devpi-server --start --host 0.0.0.0 --port 3141 --serverdir $DEVPI_SERVERDIR

if [[ $initialize = yes ]]; then
  devpi use http://localhost:3141
  devpi login root --password=''
  devpi user -m root password=""
  devpi index -y -c public pypi_whitelist='*'
fi

tail -f $DEVPI_SERVERDIR/.xproc/devpi-server/xprocess.log
