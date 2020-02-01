#!/bin/bash -x
if [ "$(aws eks describe-cluster --name ${EKS_cluster} --region ${EKS_aws_region} 2>/dev/null)" != "" ]; then
	echo "${EKS_CLUSTER} EKS cluster already created!"
        exit 0
fi

# deploy eks cluster with 3 managed nodes
eksctl create cluster --name=${EKS_cluster} \
		--nodes=${EKS_node_count} \
		--managed \
		--node-type ${EKS_node_type} \
		--region=${EKS_aws_region}
