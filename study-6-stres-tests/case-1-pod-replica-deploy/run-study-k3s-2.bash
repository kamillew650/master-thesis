#!/bin/bash

outputFilePod="result-k3s-pod.txt";
outputFileRep="result-k3s-rep.txt";
outputFileDep="result-k3s-dep.txt";


k3s kubectl create -f ./pod.yaml;

k3s kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
# k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

servicePort=`k3s kubectl get service stress-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";

echo "$result" >> ./"${folderName}/pod-sr-1";

export VUS=5;

result=`k6 run ../k6/configuration-simply-result.js`;

echo "$result" >> ./"${folderName}/pod-sr-5";

export VUS=10;

result=`k6 run ../k6/configuration-simply-result.js`;

echo "$result" >> ./"${folderName}/pod-sr-10";

export VUS=1;
export TIME_FROM=10
export TIME_TO=100

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-1-10-100";

export VUS=5;

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-5-10-100";

export VUS=10;

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-10-10-100";

export VUS=1;
export TIME_FROM=100
export TIME_TO=200

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-1-100-200";

export VUS=5;

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-5-100-200";

export VUS=10;

result=`k6 run ../k6/configuration-processing.js`;

echo "$result" >> ./"${folderName}/pod-calc-10-100-200";

sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;

sleep 5;

k3s kubectl create -f ./replica-set.yaml;

k3s kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
# k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

servicePort=`k3s kubectl get service stress-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";


export VUS=1;

result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/replica-sr-1";
export VUS=5;
result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/replica-sr-5";
export VUS=10;
result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/replica-sr-10";
export VUS=1;
export TIME_FROM=10
export TIME_TO=100
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-1-10-100";
export VUS=5;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-5-10-100";
export VUS=10;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-10-10-100";
export VUS=1;
export TIME_FROM=100
export TIME_TO=200
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-1-100-200";
export VUS=5;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-5-100-200";
export VUS=10;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/replica-calc-10-100-200";
sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete ReplicaSet stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;

sleep 5;

k3s kubectl create -f ./deployment.yaml;

k3s kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
# k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;


sleep 5;

servicePort=`k3s kubectl get service stress-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";

export VUS=1;
result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/deployment-sr-1";
export VUS=5;
result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/deployment-sr-5";
export VUS=10;
result=`k6 run ../k6/configuration-simply-result.js`;
echo "$result" >> ./"${folderName}/deployment-sr-10";
export VUS=1;
export TIME_FROM=10
export TIME_TO=100
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-1-10-100";
export VUS=5;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-5-10-100";
export VUS=10;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-10-10-100";
export VUS=1;
export TIME_FROM=100
export TIME_TO=200
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-1-100-200";
export VUS=5;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-5-100-200";
export VUS=10;
result=`k6 run ../k6/configuration-processing.js`;
echo "$result" >> ./"${folderName}/deployment-calc-10-100-200";

sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete Deployment stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;
