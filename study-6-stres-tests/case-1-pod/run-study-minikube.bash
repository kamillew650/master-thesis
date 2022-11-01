#!/bin/bash

folderName="results-minikube";

kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url=`minikube service stress-test --url`;

export SERVICE_URL=$url;

sleep 5;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-1r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-10-100-1r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-100-200-1r";

result=`k6 run ./conf-stress-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-stress-simple-1r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-10-100-1r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-100-200-1r";

result=`k6 run ./conf-spike-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-spike-simple-1r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-10-100-1r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-100-200-1r";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete ReplicaSet stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;