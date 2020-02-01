#!/bin/bash -x

if [ -n "$(kubectl get customresourcedefinitions | grep helmreleases.flux.weave.works)" ]; then
	echo "flux already installed"
	exit 0
fi

# Add the Flux helm repo and apply the flux CRDs
helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml

# Install flux, and configure it to pull from our repo
helm install --name flux \
--set rbac.create=true \
--set helmOperator.create=true \
--set helmOperator.createCRD=false \
--set git.url=${FLUX_CONFIG_REPO} \
--set git.path="${FLUX_REPO_PATH}" \
--set git-branch=${FLUX_REPO_BRANCH} \
--set prometheus.enabled=true \
--set manifest-generation=true \
--set syncGarbageCollection.enabled=true \
--namespace flux \
fluxcd/flux

# fluxcli
wget https://github.com/fluxcd/flux/releases/download/1.14.2/fluxctl_linux_amd64 -O /usr/local/bin/fluxctl
chmod +x /usr/local/bin/fluxctl
