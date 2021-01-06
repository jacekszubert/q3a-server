#!/usr/bin/env bash

set -e

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"

stack_name="quake"

echo "Updating stack"
aws cloudformation update-stack \
    --stack-name "${stack_name}" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-body "file://${scriptdir}/../templates/cloudformation-init.yaml"
aws cloudformation wait stack-update-complete \
    --stack-name "${stack_name}"
