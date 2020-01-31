#!/bin/sh
export NODE_COUNT=3
export NODE_TYPE=t3.small
export AWS_REGION=us-east-2

if [ "$(aws eks describe-cluster --name ${EKS_CLUSTER} 2>/dev/null)" != "" ]; then
	echo "${EKS_CLUSTER} EKS cluster already created!"
        exit 0
fi

# deploy eks cluster with 3 managed nodes
eksctl create cluster --name=${EKS_CLUSTER} \
		--nodes=${NODE_COUNT} \
		--managed \
		--node-type ${NODE_TYPE} \
		--alb-ingress-access \
		--region=${AWS_REGION}
