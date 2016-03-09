#!/usr/bin/env bash

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"

aws cloudformation create-stack --stack-name "${dirname}-${RANDOM}" --template-body file://cloud-formation.json
