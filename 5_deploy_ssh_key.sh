#!/bin/sh

wget https://github.com/fluxcd/flux/releases/download/1.14.2/fluxctl_linux_amd64 -O /usr/local/bin/fluxctl
chmod +x /usr/local/bin/fluxctl

GITHUB_API_TOKEN=$(aws secretsmanager get-secret-value --secret-id github-api-token --region us-east-2 | jq -r .SecretString)
GITHUB_USER=alimeerutech
KEY=$(fluxctl --k8s-fwd-ns flux identity)
TITLE=${KEY/* }
JSON=$( printf '{"title": "%s", "key": "%s", "read_only": false}' "$TITLE" "$KEY" )
curl -s -d "$JSON" -u ${GITHUB_USER}:${GITHUB_API_TOKEN} https://api.github.com/repos/meerutech/eks-gitops/keys
