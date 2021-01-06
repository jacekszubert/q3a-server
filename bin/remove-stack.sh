#!/usr/bin/env bash

set -e

stack_name="quake"

repo_name="$(aws cloudformation describe-stacks --stack-name "${stack_name}" |jq -r '.Stacks[0].Outputs[] | select(.OutputKey=="ECRName").OutputValue')"
images_sha="$(aws ecr list-images --repository-name "${repo_name}" |jq -r '.imageIds[].imageDigest')"
echo "Removing images"
aws ecr batch-delete-image \
    --repository-name "${repo_name}" \
    --image-ids "${images_sha//sha256:/imageDigest=sha256:}"

echo "Removing stack"
aws cloudformation delete-stack --stack-name "${stack_name}"
