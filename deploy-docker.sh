#!/usr/bin/env bash

scriptdir="$(readlink -f "$(dirname "${0}")")"

quake_port="${1}"
export quake_port
export COMPOSE_API_VERSION=1.18

apt-get update
apt-get -y install docker.io git python-pip aria2
pip install docker-compose
aria2c -x 16 -s 16 http://game.pioneernet.ru/dl/q3/files/pk3/pak0.pk3 --dir="${scriptdir}"

docker-compose up --file "${scriptdir}/docker-compose.yml" -d
