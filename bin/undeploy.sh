#!/usr/bin/env sh

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"


export AWS_DEFAULT_REGION=ap-southeast-2
export AWS_PROFILE=js

"${dirname}/remove-stack.sh"
