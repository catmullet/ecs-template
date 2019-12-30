#!/bin/bash
#
# Create new k8s deployment
# Update the k8s-config.yaml with image number and environment
# This file assumes that you want to deploy the most recently created
# docker image that is in ECR

set -e

. scripts/utils.sh

# Get the current image retrieves the largest image number found in the ECR
# which is assumed to be the most recently created image
DEPLOY_IMAGE_NUMBER=$(get_current_image_number)
ENVIRONMENT=$(get_environment)
KMS_NAME=$(get_kms_name)
IMAGE_NAME="563280612930.dkr.ecr.us-east-1.amazonaws.com/${KMS_NAME}-${ENVIRONMENT}:${DEPLOY_IMAGE_NUMBER}"
CLUSTER=$(get_cluster)
REGION=us-east-1

TASK_DEF_PATH=ecs/task-definition.json
TASK_DEF=$(get_updated_task_def)
NAME=${KMS_NAME}
deploy
