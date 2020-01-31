#!/bin/bash -x
if [ -n "$(kubectl get sc gp2 2>/dev/null)" ]; then
	kubectl delete storageclass gp2
fi
