#!/bin/bash
exec 2>&1
set -uem
export LANG=en_US.UTF-8

err=0

if [ -z "$DISTRIBUTION_ID" ]; then
  echo "error: DISTRIBUTION_ID is not set"
  err=1
fi

if [ -z "$PATHS" ]; then
  echo "error: PATHS is not set"
  err=1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "error: AWS_ACCESS_KEY_ID is not set"
  err=1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "error: AWS_SECRET_ACCESS_KEY is not set"
  err=1
fi

if [ -z "$AWS_REGION" ]; then
  echo "error: AWS_REGION is not set"
  err=1
fi

if [ $err -eq 1 ]; then
  exit 1
fi

INVALIDATION_ID=$(AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" AWS_REGION="$AWS_REGION" aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths "$PATHS" $* | jq -r '.Invalidation.Id')

INVALIDATION_STATUS="InProgress"

while [ $INVALIDATION_STATUS = "InProgress" ]
do
  sleep 10
  INVALIDATION_STATUS=$(AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" AWS_REGION="$AWS_REGION" aws cloudfront get-invalidation --distribution-id "$DISTRIBUTION_ID" --id "$INVALIDATION_ID" | jq -r '.Invalidation.Status')
done
