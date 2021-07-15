#!/usr/bin/env bash

set -exu

echo "$@"

URL="$1"
MASTER_CLUSTER="$2"
MASTER_SERVICE="$3"
MASTER_PORT="$4"

export AWS_DEFAULT_REGION=$(curl http://169.254.169.254/latest/meta-data/placement/region)

curl "$URL" -o locustfile.py

MASTER_HOST="$(python find_master.py "$MASTER_CLUSTER" "$MASTER_SERVICE")"

locust --worker --master-host="$MASTER_HOST" --master-port="$MASTER_PORT"
