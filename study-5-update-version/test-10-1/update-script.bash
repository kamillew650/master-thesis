#!/bin/bash

echo $(date +"%S,%6N");
kubectl delete Deployment test-deployment-update --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

while ($(kubectl get Deployment | grep -q 'test-deployment-update') )
do
echo 'not ready'
done
kubectl create -f ./deployment-v2.yaml;

