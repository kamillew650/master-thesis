#!/bin/bash

echo $(date +"%S,%6N");
kubectl create -f ./deployment.yaml;
# kubectl get pod test-pod -o yaml | grep -A 17 conditions;

