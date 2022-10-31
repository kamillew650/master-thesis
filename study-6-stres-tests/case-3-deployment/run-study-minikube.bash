#!/bin/bash

series=(1 2 3);

outputFilePod="result-minikube-pod.txt";
outputFileRep="result-minikube-rep.txt";
outputFileDep="result-minikube-dep.txt";


kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url=`minikube service stress-test --url`;

export SERVICE_URL=$url;

sleep 5;

echo "start run ${s}" >> ./"${outputFilePod}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFilePod}";

echo "-----------------------" >> ./"${outputFilePod}";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;


kubectl create -f ./replica-set.yaml;

kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url=`minikube service stress-test --url`;

export SERVICE_URL=$url;

sleep 5;

echo "start run ${s}" >> ./"${outputFileRep}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFileRep}";

echo "-----------------------" >> ./"${outputFileRep}";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete ReplicaSet stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;


kubectl create -f ./deployment.yaml;

kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url=`minikube service stress-test --url`;

export SERVICE_URL=$url;

sleep 5;

echo "start run ${s}" >> ./"${outputFileDep}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFileDep}";

echo "-----------------------" >> ./"${outputFileDep}";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete Deployment stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;