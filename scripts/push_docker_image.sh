#!/bin/bash
#
# Pushes docker images to AWS ECR
# The image number used is the most recently uploaed image number + 1
#
# The 'latest' tag is created for edge cases when we just want to deploy most recent
# build without knowing the latest image number (not ideal for everday use)

set -e

. scripts/utils.sh

ENVIRONMENT=$(get_environment)
KMS_NAME=$(get_kms_name)
IMAGE_NUMBER=$(get_next_image_number)

docker push 563280612930.dkr.ecr.us-east-1.amazonaws.com/${KMS_NAME}-${ENVIRONMENT}:latest
docker push 563280612930.dkr.ecr.us-east-1.amazonaws.com/${KMS_NAME}-${ENVIRONMENT}:${IMAGE_NUMBER}
