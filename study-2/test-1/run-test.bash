#!/bin/bash

echo $(date +"%Y-%m-%dT%H:%M:%S%z");
kubectl create -f ./test.yaml;
sleep 5;
kubectl get pod test-pod -o yaml | grep -A 17 conditions;

