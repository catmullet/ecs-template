#!/bin/bash
#
# Build the go binary from the code in src/web
# Use docker to pull down dependencies and build the binary

set -e

. scripts/utils.sh

# build binaries for mac if needed
if [[ -z ${GOOS} ]]; then GOOS=linux; fi
GO_VERSION=1.10
KMS_NAME=$(get_kms_name)
ENVIRONMENT=$(get_environment)
BUILD=$(get_build)
BRANCH_NAME=$(get_branch)

echo "Building binary:"
echo "  KMS name:    ${KMS_NAME}"
echo "  Environment: ${ENVIRONMENT}"
echo "  Build:       ${BUILD}"
echo "  Branch:      ${BRANCH_NAME}"
echo "  GO version:  ${GO_VERSION}"
docker run --rm -i \
       -v ${HOME}/.ssh:/root/.ssh \
       -v ${HOME}/.gitconfig:/root/.gitconfig \
       -v ${PWD}:/go/src/github.com/kyani-inc/${KMS_NAME} \
       -w /go/src/github.com/kyani-inc/${KMS_NAME} \
       golang:${GO_VERSION} \
       sh -c "cd src/api && go get -d && \
	     GOOS=${GOOS} CGO_ENABLED=0 go build -a -tags=\"${ENVIRONMENT}\" -ldflags=\"-s\" \
	     -o ../../bin/${GOOS}/${KMS_NAME} -ldflags \"-X main.BUILD=${BUILD}\" ."

if [ $? -eq 0 ]; then
    echo "${GOOS} binary successfully built at bin/${GOOS}/${KMS_NAME}"
fi
