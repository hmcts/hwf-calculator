#! /bin/bash
set -e

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $ZAP_HOST)" != "200" ]]; do
  >&2 echo "Waiting for ZAP to start"
  sleep 2
done

DRIVER=zap bundle exec cucumber --tags @zap
