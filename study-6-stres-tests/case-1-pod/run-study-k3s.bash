#!/bin/bash

folderName="results-k3s";

k3s kubectl create -f ./pod.yaml;

k3s kubectl expose pod stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;
# k3s kubectl create service LoadBalancer stress-test --node-port=30100 --tcp=4000:4000;

sleep 5;

servicePort=`k3s kubectl get service stress-test -o=jsonpath='{.spec.ports[?(@.port==4000)].nodePort}'`

export SERVICE_URL="http://localhost:${servicePort}";

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

k3s kubectl delete service stress-test --grace-period=0 --force;
k3s kubectl delete --all pods --grace-period=0 --force;