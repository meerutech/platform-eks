#!/bin/bash -x

if [ "$(aws eks describe-cluster --name ${EKS[eks_cluster]} 2>/dev/null)" != "" ]; then
	echo "${EKS[eks_cluster]} EKS cluster already created!"
        exit 0
fi

# deploy eks cluster with 3 managed nodes
eksctl create cluster --name=${EKS[eks_cluster]} \
		--nodes=${EKS[node_count]} \
		--managed \
		--node-type ${EKS[node_type]} \
		--region=${EKS[aws_default_region]}
