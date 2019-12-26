#!/bin/bash
#
# Build the Dockerfile at the root directory of the project.
# If consul is running on the local host and has relevant key/values
# inject them into the Dockerfile. Otherwise look for an env file
# and inject it into the Dockerfile.
#
# It is assumed that the largest image tag number is also the
# most recently created image uploaded. So that number + 1 is used
# as the tag for image built by the file
#
# The 'latest' tag is created for edge cases when we just want to deploy most recent
# build without knowing the latest image number (not ideal for everday use)

set -e

. scripts/utils.sh

ENVIRONMENT=$(get_environment)
KMS_NAME=$(get_kms_name)
IMAGE_NUMBER=$(get_next_image_number) 

docker build -t 563280612930.dkr.ecr.us-east-1.amazonaws.com/${KMS_NAME}-${ENVIRONMENT}:latest .
docker build -t 563280612930.dkr.ecr.us-east-1.amazonaws.com/${KMS_NAME}-${ENVIRONMENT}:${IMAGE_NUMBER} .
