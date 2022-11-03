#!/bin/bash

folderName="results-kind";

kubectl create -f ./deployment.yaml;

kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export SERVICE_URL="http://localhost:30100";

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-1r";

kubectl scale Deployment stress-test --replicas=5;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-5r";


kubectl scale Deployment stress-test --replicas=10;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-10r";


kubectl scale Deployment stress-test --replicas=20;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-20r";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete Deployment stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
