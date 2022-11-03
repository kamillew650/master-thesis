#!/bin/bash

folderName="results-minikube";

kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url=`minikube service stress-test --url`;

export SERVICE_URL=$url;

sleep 5;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-1r";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;