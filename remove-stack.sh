#!/usr/bin/env bash

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"

for stack in $(aws cloudformation describe-stacks --output json |awk -F\" '/StackName.*'${dirname}'/ {print $4}'); do
    echo "deleting ${stack}"
    aws cloudformation delete-stack --stack-name "${stack}"
done
