#!/bin/bash
#
# This file contains helper functions that are used in various other scripts.
# The functions are not intended to be usefull outside of the other bash
# files in the scripts/ directory but may come in handy at some point.

get_kms_name() {
    # one way to get the current git repo name
    echo "kms-api-enroll"
}

get_branch() {
    # not a good idea to use this to actually checkout git branches
    # this is mostly just good for use in getting the environment from get_environment()

    # TODO remember to turn this back on
    # if we are in a jenkins build then the BRANCH_NAME env var will be set
    if [ -z ${BRANCH_NAME} ]; then
    		# one way to get the current branch
    		git branch | grep "\*" | cut -d' ' -f 2
    else
    		echo ${BRANCH_NAME}
    fi
}

get_environment() {
    local BRANCH_NAME=$(get_branch)
    echo ${BRANCH_NAME} | grep -q master && echo production || echo $(get_branch)
}

get_cluster() {
    local BRANCH_NAME=$(get_branch)
    echo ${BRANCH_NAME} | grep -q master && echo production || echo staging
}

get_current_image_number() {
    local KMS_NAME=$(get_kms_name)
    local ENVIRONMENT=$(get_environment)
    aws ecr list-images --region us-east-1 \
				--repository-name ${KMS_NAME}-${ENVIRONMENT} \
				--query 'imageIds[].imageTag' \
				--output text \
				| tr '\t' '\n' \
				| sort -nr \
				| head -n1
}

get_next_image_number() {
    local CURRENT=$(get_current_image_number)
    ((CURRENT++))
    echo ${CURRENT}
}

get_k8s_cluster() {
    local BRANCH_NAME=$(get_branch)
    echo ${BRANCH_NAME} | grep -q master && echo k8s-pro.kyanisecure.com || echo k8s-dev.kyanisecure.com
}

get_build() {
    local BUILD_TIME=$(sh -c "date -u +%m%d%H%M")
    if [[ ${BUILD_NUMBER} == "" ]]; then
				BUILD_NUMBER=local_build
    fi
    echo "${BUILD_TIME}-${BUILD_NUMBER}"
}

get_sed() {
    if [[ `uname` == Linux ]]; then
				echo sed
    else
				echo gsed
    fi
}

deploy() {
    echo "Environment:   ${ENVIRONEMNT}"
    echo "KMS Name:      ${KMS_NAME}"
    echo "ECS Cluster:   ${CLUSTER}"
    echo "Image :        ${IMAGE_NAME}"
    echo

    echo "${TASK_DEF}"
    echo
    echo "Registering task definition..."
    aws ecs register-task-definition \
				--region us-east-1 \
				--cli-input-json "${TASK_DEF}"
    sleep 2

    echo "Updating service..."
    echo "service: ${KMS_NAME}"
    echo "task-definition: ${KMS_NAME}"
    aws ecs update-service \
				--cluster ${CLUSTER} \
				--region ${REGION} \
				--service ${NAME} \
				--task-definition ${NAME}-${ENVIRONMENT}
}

get_updated_task_def() {

    local NAME=$(get_kms_name)
    local ENVIRONMENT=$(get_environment)
    local TASK_DEF=$(cat ${TASK_DEF_PATH})
    local VARIABLES_JSON=$(envi g -i ${NAME}__${ENVIRONMENT} -o json)
    TASK_DEF=$(echo "${TASK_DEF}" | jq --argjson env_vars "$VARIABLES_JSON" '.containerDefinitions[0].environment=$env_vars')
    TASK_DEF=${TASK_DEF//KMS_NAME/${KMS_NAME}}
    TASK_DEF=${TASK_DEF//IMAGE_NAME/${IMAGE_NAME}}
    TASK_DEF=${TASK_DEF//WORKER_NAME/${WORKER_NAME}}
    TASK_DEF=${TASK_DEF//ENVIRONMENT/${ENVIRONMENT}}
    TASK_DEF=$(echo "${TASK_DEF}" | sed "s|ENVIRONMENT|${ENVIRONMENT}|g")

    echo "${TASK_DEF}"
}
