#!/bin/bash

GITHUB_API_TOKEN=$(aws secretsmanager get-secret-value --secret-id github-api-token --region us-east-2 | jq -r .SecretString)
KEY=$(fluxctl --k8s-fwd-ns flux identity)
TITLE=${KEY/* }
JSON=$( printf '{"title": "%s", "key": "%s", "read_only": false}' "$TITLE" "$KEY" )
curl -s -d "$JSON" -u ${FLUX[github_user]}:${GITHUB_API_TOKEN} ${FLUX[config_repo]}/keys
