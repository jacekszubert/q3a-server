#!/usr/bin/env bash

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"

stack_name="quake"

aws cloudformation delete-stack --stack-name "${stack}"
