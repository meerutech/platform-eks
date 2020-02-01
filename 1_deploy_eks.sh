#!/bin/bash -x
if [ "$(aws eks describe-cluster --name ${EKS_CLUSTER} --region ${EKS_AWS_REGION} 2>/dev/null)" != "" ]; then
	echo "${EKS_CLUSTER} EKS cluster already created!"
        exit 0
fi

# deploy eks cluster with 3 managed nodes
eksctl create cluster --name=${EKS_CLUSTER} \
		--nodes=${EKS_NODE_COUNT} \
		--managed \
		--node-type ${EKS_NODE_TYPE} \
		--region=${EKS_AWS_REGION}
