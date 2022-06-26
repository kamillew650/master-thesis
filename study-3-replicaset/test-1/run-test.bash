#!/bin/bash

echo $(gdate +"%Y-%m-%dT%H:%M:%S%z");
kubectl create -f ./replica-set.yaml;
# kubectl get pod test-pod -o yaml | grep -A 17 conditions;

