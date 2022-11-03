#!/bin/bash

folderName="results-minikube";

kubectl create -f ./replica-set.yaml;

kubectl expose ReplicaSet scale-test --target-port 4000 --name scale-test --type=LoadBalancer --port 4000;

sleep 5;

url=`minikube service scale-test --url`;

export SERVICE_URL=$url;

startTime=$(date +"%s%3N");
echo "$startTime" >> ./"${folderName}/conf-stess-simple-1r-logs";

kubectl autoscale ReplicaSet scale-test --min=1 --max=5 --cpu-percent=10;

# result=`k6 run ./conf-load-test-simple.js`;

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-10-100-1r";

logs=`kubectl logs --all-containers=true -l app=scale-test`;
echo "$logs" >> ./"${folderName}/conf-spike-calc-10-100-1r-logs";

sleep 3;

kubectl delete hpa scale-test --grace-period=0 --force;
kubectl delete service scale-test --grace-period=0 --force;
kubectl delete ReplicaSet scale-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;