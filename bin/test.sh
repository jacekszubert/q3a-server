#!/usr/bin/env sh

set -e

HOST="${1-localhost}"
PORT="${2:-27960}"

echo 'getstatus'
printf "\xFF\xFF\xFF\xFFgetstatus xxx" |nc -u -w1 "${HOST}" "${PORT}"
echo 'getinfo'
printf "\xFF\xFF\xFF\xFFgetinfo xxx" |nc -u -w1 "${HOST}" "${PORT}"
echo 'ok'
