#!/bin/bash

folderName="results-kind";

kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export SERVICE_URL="http://localhost:30100";

export VUS=1;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/pod-sr-1";
export VUS=5;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/pod-sr-5";
export VUS=10;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/pod-sr-10";
export VUS=1;
export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-1-10-100";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-5-10-100";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-10-10-100";
export VUS=1;
export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-1-100-200";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-5-100-200";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/pod-calc-10-100-200";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
sleep 5;

kubectl create -f ./replica-set.yaml;

kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export VUS=1;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/replica-sr-1";
export VUS=5;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/replica-sr-5";
export VUS=10;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/replica-sr-10";
export VUS=1;
export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-1-10-100";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-5-10-100";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-10-10-100";
export VUS=1;
export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-1-100-200";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-5-100-200";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-10-100-200";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete ReplicaSet stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;

sleep 5;

kubectl create -f ./deployment.yaml;

kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export VUS=1;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/deployment-sr-1";
export VUS=5;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/deployment-sr-5";
export VUS=10;
result=`k6 run ./configuration-simple-resp.js`;
echo "$result" >> ./"${folderName}/deployment-sr-10";
export VUS=1;
export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-1-10-100";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-5-10-100";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-10-10-100";
export VUS=1;
export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-1-100-200";
export VUS=5;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-5-100-200";
export VUS=10;
result=`k6 run ./configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-10-100-200";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete Deployment stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
