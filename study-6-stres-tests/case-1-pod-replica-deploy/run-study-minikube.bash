#!/bin/bash

series=(1 2 3);

outputFile="result-minikube-pod.txt";

kubectl create -f ./pod.yaml;

kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

url = minikube service stress-test --url;

export SERVICE_URL=$url;

sleep 5;

for s in ${series[@]}; do

    echo "start run ${s}" >> ./"${outputFile}";
    
    result=`k6 run ../k6/configuration.js`;

    echo "$result" >> ./"${outputFile}";

    echo "-----------------------" >> ./"${outputFile}";

    sleep 3;

done

kubectl delete --all pods --grace-period=0 --force;


# kubectl create -f ./replica-set.yaml;

# kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

# minikube service stress-test --url;

# sleep 5;

# kubectl delete ReplicaSet stress-test --grace-period=0 --force;
# kubectl delete --all pods --grace-period=0 --force;