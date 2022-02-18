#!/usr/bin/env bash

set -e
set -o pipefail

ARGS_N=1 && source $(dirname $0)/check-args.sh

if [ -z "$S3_BUCKET" ]
then
  echo "Please specify environment variable: S3_BUCKET"
  exit 1
fi

if [ -z "$DRONE_REPO_NAME" ]
then
  echo "Please specify environment variable: DRONE_REPO_NAME"
  exit 1
fi

if [ -z "$DRONE_BUILD_NUMBER" ]
then
  echo "Please specify environment variable: DRONE_BUILD_NUMBER"
  exit 1
fi

if [ -z "$DRONE_COMMIT_SHA" ]
then
  echo "Please specify environment variable: DRONE_COMMIT_SHA"
  exit 1
fi

if [ -z "$ECR_ACCESS_KEY" ]
then
  echo "Please specify environment variable: ECR_ACCESS_KEY"
  exit 1
fi

if [ -z "$ECR_SECRET_KEY" ]
then
  echo "Please specify environment variable: ECR_SECRET_KEY"
  exit 1
fi

ITEM=$1

source env/bin/activate 2> /dev/null || /bin/true

S3_PATH="${S3_PATH:-$S3_BUCKET/$DRONE_REPO_NAME/$DRONE_BUILD_NUMBER/$DRONE_COMMIT_SHA}"

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-$ECR_ACCESS_KEY}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-$ECR_SECRET_KEY}"

echo "We are going to upload $ITEM to $S3_PATH/$ITEM"
aws s3 sync $ITEM s3://$S3_PATH

ARTIFACTS_URL="${ARTIFACTS_URL:-https://${ARTIFACTS_SERVER^^}/$DRONE_REPO_NAME/$DRONE_BUILD_NUMBER/$DRONE_COMMIT_SHA/}"
echo "Artifacts url: $ARTIFACTS_URL"

if [ -z "$SKIP_GITHUB_STATUS" ]; then
  ./$(dirname $0)/github-status.sh success 'ci/cd artifacts' 'uploaded' ${ARTIFACTS_URL}
fi
