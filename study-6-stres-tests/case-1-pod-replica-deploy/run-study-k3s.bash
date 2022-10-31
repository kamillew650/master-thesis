#!/bin/bash

outputFilePod="result-kind-pod-2.txt";
outputFileRep="result-kind-rep-2.txt";
outputFileDep="result-kind-dep-2.txt";


k3s kubectl create -f ./pod.yaml;

# k3s kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

export SERVICE_URL="http://localhost:30100";


echo "start run ${s}" >> ./"${outputFilePod}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFilePod}";

echo "-----------------------" >> ./"${outputFilePod}";

sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;

sleep 5;

k3s kubectl create -f ./replica-set.yaml;

# k3s kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

k3s kubectl port-forward service/stress-test 30100:4000&

# export SERVICE_URL="localhost:30100";


echo "start run ${s}" >> ./"${outputFileRep}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFileRep}";

echo "-----------------------" >> ./"${outputFileRep}";

sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete ReplicaSet stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;

sleep 5;

k3s kubectl create -f ./deployment.yaml;

# k3s kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;


sleep 5;

k3s kubectl port-forward service/stress-test 30100:4000&

echo "start run ${s}" >> ./"${outputFileDep}";

result=`k6 run ../k6/configuration.js`;

echo "$result" >> ./"${outputFileDep}";

echo "-----------------------" >> ./"${outputFileDep}";

sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete Deployment stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
