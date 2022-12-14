#!/bin/bash

folderName="results-kind";

kubectl create -f ./deployment.yaml;

kubectl expose Deployment stress-test --target-port 4000 --name stress-test --type=LoadBalancer --port 4000;

sleep 5;

kubectl port-forward service/stress-test 30100:4000&

export SERVICE_URL="http://localhost:30100";

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

kubectl scale Deployment stress-test --replicas=5;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-5r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-10-100-5r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-100-200-5r";

result=`k6 run ./conf-stress-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-stress-simple-5r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-10-100-5r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-100-200-5r";

result=`k6 run ./conf-spike-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-spike-simple-5r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-10-100-5r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-100-200-5r";


kubectl scale Deployment stress-test --replicas=10;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-10r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-10-100-10r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-100-200-10r";

result=`k6 run ./conf-stress-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-stress-simple-10r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-10-100-10r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-100-200-10r";

result=`k6 run ./conf-spike-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-spike-simple-10r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-10-100-10r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-100-200-10r";

kubectl scale Deployment stress-test --replicas=20;

sleep 10;

result=`k6 run ./conf-load-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-load-simple-20r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-10-100-20r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-load-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-load-calc-100-200-20r";

result=`k6 run ./conf-stress-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-stress-simple-20r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-10-100-20r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-stress-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-stress-calc-100-200-20r";

result=`k6 run ./conf-spike-test-simple.js`;
echo "$result" >> ./"${folderName}/conf-spike-simple-20r";

export TIME_FROM=10
export TIME_TO=100
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-10-100-20r";

export TIME_FROM=100
export TIME_TO=200
result=`k6 run ./conf-spike-test-calc.js`;
echo "$result" >> ./"${folderName}/conf-spike-calc-100-200-20r";

sleep 3;

kubectl delete service stress-test --grace-period=0 --force;
kubectl delete Deployment stress-test --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;

pkill -f port-forward;
