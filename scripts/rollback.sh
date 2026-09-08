#!/usr/bin/env bash
set -e

PREVIOUS_TAG=$1

if [ -z "$PREVIOUS_TAG" ]; then
  echo "Error: No previous tag provided for rollback!"
  exit 1
fi

echo "Initiating ROLLBACK to image tag: ${PREVIOUS_TAG}..."

IMAGE_TAG=$PREVIOUS_TAG docker compose -f docker/docker-compose.prod.yml up -d --force-recreate

echo "Rollback to ${PREVIOUS_TAG} completed successfully."
