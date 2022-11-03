#!/bin/bash

folderName="results-k3s";

k3s kubectl create -f ./replica-set.yaml;

k3s kubectl expose ReplicaSet stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

servicePort=`k3s kubectl get service stress-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";

startTime=$(date +"%s%3N");
echo "$logs" >> ./"${folderName}/conf-load-simple-1r-logs";

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-1r";

logs=`k3s kubectl logs --all-containers=true -l app=test-deployment`;
echo "$logs" >> ./"${folderName}/conf-load-simple-1r-logs";



sleep 3;

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete ReplicaSet stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;