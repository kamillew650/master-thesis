#!/bin/bash

echo $(gdate +"%Y-%m-%dT%H:%M:%S%z");
kubectl delete Deployment deployment-update;

while ( $(kubectl get Deployment | grep -q 'No resources found in default namespace.No resources found in default namespace.' ) )
do
echo 'no'
done
kubectl create -f ./deployment-v2.yaml;




# kubectl get pod test-pod -o yaml | grep -A 17 conditions;

