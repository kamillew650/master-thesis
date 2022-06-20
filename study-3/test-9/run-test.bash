#!/bin/bash

echo $(gdate +"%T.%6N");
kubectl create -f ./replica-set.yaml;
# kubectl get pod test-pod -o yaml | grep -A 17 conditions;

