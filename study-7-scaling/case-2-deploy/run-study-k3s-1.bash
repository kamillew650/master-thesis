#!/bin/bash

folderName="results-k3s";
fileName="load-1-5-cpu-10"


k3s kubectl create -f ./deployment.yaml;

k3s kubectl expose Deployment scale-test --target-port 4000 --name scale-test --type=LoadBalancer --port 4000;

sleep 5;

servicePort=`k3s kubectl get service scale-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";

startTime=$(date +"%s%3N");
echo "$startTime" >> ./"${folderName}/${fileName}-logs";

k3s kubectl autoscale Deployment scale-test --min=1 --max=5 --cpu-percent=10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/${fileName}";

logs=`k3s kubectl logs --all-containers=true -l app=scale-test`;
echo "$logs" >> ./"${folderName}/${fileName}-logs";

sleep 3;

k3s kubectl delete hpa scale-test --grace-period=0 --force;
k3s kubectl delete service scale-test --grace-period=0 --force;
k3s kubectl delete Deployment scale-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;