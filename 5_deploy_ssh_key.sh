#!/bin/bash -x

GITHUB_API_TOKEN=$(aws secretsmanager get-secret-value --secret-id github-api-token --region ${EKS_aws_region} | jq -r .SecretString)

if [ -n "$(curl -s -u ${FLUX_github_user}:${GITHUB_API_TOKEN} ${FLUX_github_api_endpoint}/keys \
    | jq '.[] | select(.title=="${FLUX_github_deploy_key}").id')" ];then
    echo "deploy key already uploaded into github"
    exit 0
fi
KEY=$(fluxctl --k8s-fwd-ns flux identity)
TITLE=${FLUX_github_deploy_key}
JSON=$( printf '{"title": "%s", "key": "%s", "read_only": false}' "$TITLE" "$KEY" )
curl -s -d "$JSON" -u ${FLUX_github_user}:${GITHUB_API_TOKEN} ${FLUX_github_api_endpoint}/keys
