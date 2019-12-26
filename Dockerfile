FROM 563280612930.dkr.ecr.us-east-1.amazonaws.com/alpine:basic
MAINTAINER Kyäni, Inc. <devops@kyanicorp.com>

EXPOSE 80

# if 'KMS_NAME' is not replaced then the build_docker_image.sh script will
# replace 'KMS_NAME' with the string returned from utils.sh get_kms_name()
ADD bin/linux/example /opt/example
ADD tmp /opt/tmp
WORKDIR /opt
CMD /opt/example
