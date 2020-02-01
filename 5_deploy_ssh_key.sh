#!/bin/bash -x

GITHUB_API_TOKEN=$(aws secretsmanager get-secret-value --secret-id github-api-token --region ${EKS_aws_region} | jq -r .SecretString)
KEY=$(fluxctl --k8s-fwd-ns flux identity)
TITLE=${KEY/* }
JSON=$( printf '{"title": "%s", "key": "%s", "read_only": false}' "$TITLE" "$KEY" )
curl -s -d "$JSON" -u ${FLUX_github_user}:${GITHUB_API_TOKEN} ${FLUX_config_repo}/keys
