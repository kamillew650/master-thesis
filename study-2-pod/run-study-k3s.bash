#!/bin/bash

variants=(1 5 10 20);
series=(1 2 3);

outputFile="result-k3s.txt";


for v1 in ${variants[@]}; do
  for s in ${series[@]}; do
  
    echo $v1;
    echo $v2;
    cd ./"test-${v1}";

    echo "start run ${s}" >> ./"${outputFile}";

    startTime=$(date +"%S,%6N");
    k3s kubectl create -f ./test.yaml;


    # ./run-test.bash >> ./result.txt;

    resultLines=`k3s kubectl logs --all-containers=true test-pod | wc -l`;
    requiredAmountOfLines=$(($v1));

    sleep $v1;

    echo $resultLines;
    echo $requiredAmountOfLines;
    while ((resultLines < requiredAmountOfLines)); do
      echo "waiting for get-logs to finish";
      sleep 5s;
      resultLines=`k3s kubectl logs --all-containers=true test-pod | wc -l`;
    done;

    endTime=$(k3s kubectl logs --all-containers=true test-pod | sort -r | head -n 1);

    echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";

    k3s kubectl delete --all pods --grace-period=0 --force;

    sleep 3;

    cleanUpResult=`k3s kubectl logs --all-containers=true test-pod | sort -r | head -n 1 | grep "not found"`;

    while ! $cleanUpResult; do
      echo "waiting for clean-up to finish";
      sleep 1;
      cleanUpResult=`k3s kubectl logs --all-containers=true test-pod | sort -r | head -n 1 | grep "not found"`;
    done;

    cd ..;
  done
done