#!/usr/bin/env bash

set -e

scriptdir="$(readlink -f "$(dirname "${0}")")"
dirname="$(basename "${scriptdir}")"

stack_name="quake"

#echo "Creating stack"
#aws cloudformation create-stack \
#    --stack-name "${stack_name}" \
#    --template-body "file://${scriptdir}/../templates/cloudformation-init.yaml"
#aws cloudformation wait stack-create-complete \
#    --stack-name "${stack_name}"

ret="$(aws cloudformation describe-stacks \
    --stack-name "${stack_name}")"
repo_uri="$(echo "${ret}" |jq -r '.Stacks[0].Outputs[0].OutputValue')"
export DOCKER_IMAGE="${repo_uri}:latest"
echo "Building image"
docker-compose -f docker-compose.yml -f docker-compose.deploy.yml build
aws ecr get-login-password |docker login --username AWS --password-stdin "${repo_uri}"
echo "Pushing image"
docker-compose -f docker-compose.yml -f docker-compose.deploy.yml push

echo "Updating stack"
aws cloudformation update-stack \
    --stack-name "${stack_name}" \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-body "file://${scriptdir}/../templates/cloudformation.yaml" \
    --parameters ParameterKey=Image,ParameterValue="${DOCKER_IMAGE}" \
    	ParameterKey=HealthcheckImage,ParameterValue="${DOCKER_IMAGE}-healthcheck"
aws cloudformation wait stack-update-complete \
    --stack-name "${stack_name}"
