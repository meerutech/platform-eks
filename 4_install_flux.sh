#!/bin/sh
export CONFIG_REPO=git@github.com:meerutech/platform-config

# Add the Flux helm repo and apply the flux CRDs
helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml

# Install flux, and configure it to pull from our repo
helm install --name flux \
--set rbac.create=true \
--set helmOperator.create=true \
--set helmOperator.createCRD=false \
--set git.url=${CONFIG_REPO} \
--set git.path="repos" \
--set git-branch=master \
--set prometheus.enabled=true \
--set manifest-generation=true \
--set syncGarbageCollection.enabled=true \
--namespace flux \
fluxcd/flux
