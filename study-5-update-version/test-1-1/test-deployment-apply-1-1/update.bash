#!/bin/bash

echo $(gdate +"%Y-%m-%dT%H:%M:%S%z");
kubectl apply -f ./deployment-v2.yaml;
# kubectl get pod test-pod -o yaml | grep -A 17 conditions;

