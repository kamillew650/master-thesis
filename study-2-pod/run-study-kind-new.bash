#!/bin/bash

variants=(1 5 10 20);
series=(1 2 3);

outputFile="result-kind.txt";

for v1 in ${variants[@]}; do
  for s in ${series[@]}; do
  
    echo $v1;
    echo $v2;
    cd ./"test-${v1}";

    echo "start run ${s}" >> ./"${outputFile}";

    startTime=$(date +"%s,%6N");
    kubectl create -f ./test.yaml;

    resultLines=`kubectl logs --all-containers=true test-pod | wc -l`;
    requiredAmountOfLines=$(($v1));

    sleep $v1;

    echo $resultLines;
    echo $requiredAmountOfLines;
    while ((resultLines < requiredAmountOfLines)); do
      echo "waiting for get-logs to finish";
      sleep 5s;
      resultLines=`kubectl logs --all-containers=true test-pod | wc -l`;
    done;

    endTime=$(kubectl logs --all-containers=true test-pod | sort -r | head -n 1);

    echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";

    kubectl delete --all pods --grace-period=0 --force;

    sleep 3;

    cleanUpResult=`kubectl logs --all-containers=true test-pod | sort -r | head -n 1 | grep "not found"`;

    while ! $cleanUpResult; do
      echo "waiting for clean-up to finish";
      sleep 1;
      cleanUpResult=`kubectl logs --all-containers=true test-pod | sort -r | head -n 1 | grep "not found"`;
    done;

    cd ..;
  done
done