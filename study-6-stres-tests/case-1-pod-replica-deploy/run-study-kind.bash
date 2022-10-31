#!/bin/bash

outputFilePod="result-kind-pod-2.txt";
outputFileRep="result-kind-rep-2.txt";
outputFileDep="result-kind-dep-2.txt";


kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
# kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export SERVICE_URL="http://localhost:30100";


echo "start run ${s}" >> ./"${outputFilePod}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFilePod}";

echo "-----------------------" >> ./"${outputFilePod}";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
sleep 5;

kubectl create -f ./replica-set.yaml;

kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

# export SERVICE_URL="localhost:30100";


echo "start run ${s}" >> ./"${outputFileRep}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFileRep}";

echo "-----------------------" >> ./"${outputFileRep}";

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

echo "start run ${s}" >> ./"${outputFileDep}";

result=`k6 run ./k6/configuration.js`;

echo "$result" >> ./"${outputFileDep}";

echo "-----------------------" >> ./"${outputFileDep}";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete Deployment stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
