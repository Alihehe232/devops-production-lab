#!/usr/bin/env bash
set -e

HOST=${1:-"localhost"}
PORT=${2:-"80"}
RETRIES=5
WAIT_SECONDS=3

echo "Checking health at http://${HOST}:${PORT}/health..."

for i in $(seq 1 $RETRIES); do
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://${HOST}:${PORT}/health" || true)
  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "Healthcheck PASSED! (HTTP 200)"
    exit 0
  fi
  echo "Attempt $i/$RETRIES failed (HTTP $HTTP_STATUS). Retrying in ${WAIT_SECONDS}s..."
  sleep $WAIT_SECONDS
done

echo "Healthcheck FAILED after $RETRIES attempts."
exit 1