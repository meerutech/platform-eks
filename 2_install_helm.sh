#!/bin/bash
eksctl utils write-kubeconfig --cluster ${EKS[eks_cluster]}
# check if helm is already installed
if [ -n "$(kubectl get serviceaccounts --namespace=kube-system tiller 2>/dev/null)" ]; then
	echo "helm already installed!"
	exit 0
fi

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh

chmod +x /tmp/get_helm.sh

cat <<EoF > /tmp/rbac.yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EoF

kubectl apply -f /tmp/rbac.yaml

/tmp/get_helm.sh

helm init --service-account tiller
