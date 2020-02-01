#!/bin/bash -x

# install fluxcli
wget https://github.com/fluxcd/flux/releases/download/1.14.2/fluxctl_linux_amd64 -O /usr/local/bin/fluxctl
chmod +x /usr/local/bin/fluxctl

GITHUB_API_TOKEN=$(aws secretsmanager get-secret-value --secret-id github-api-token --region ${AWS_DEFAULT_REGION} | jq -r .SecretString)

KEY=$(fluxctl --k8s-fwd-ns flux identity)
TITLE=${KEY/* }

if [ -n "$(curl -s -u ${FLUX_github_user}:${GITHUB_API_TOKEN} ${FLUX_github_api_endpoint}/keys \
    | jq '.[] | select(.title=="${TITLE}").id')" ];then
    echo "deploy key already uploaded into github"
    exit 0
fi

JSON=$( printf '{"title": "%s", "key": "%s", "read_only": false}' "$TITLE" "$KEY" )
curl -s -d "$JSON" -u ${FLUX_github_user}:${GITHUB_API_TOKEN} ${FLUX_github_api_endpoint}/keys
