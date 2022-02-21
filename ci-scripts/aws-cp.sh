#!/usr/bin/env bash

set -e
set -o pipefail

SOURCE_PATH=$1
TARGET_PATH=$2
OPTIONS=$3

source env/bin/activate 2> /dev/null || /bin/true

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-$ECR_ACCESS_KEY}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-$ECR_SECRET_KEY}"

echo "Going to copy $SOURCE_PATH to $TARGET_PATH"
aws s3 cp $SOURCE_PATH $TARGET_PATH $OPTIONS