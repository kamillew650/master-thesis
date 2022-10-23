#!/bin/bash

variants=(1 5 10 20);
variants1=(20);
variants2=(10);
series=(1 2 3);

outputFile="result-k3s-2.txt";


for v1 in ${variants1[@]}; do
  for v2 in ${variants2[@]}; do
    for s in ${series[@]}; do
    
      echo $v1;
      echo $v2;
      cd ./"test-${v1}-${v2}";

      echo "start run ${s}" >> ./"${outputFile}";

      startTime=$(date +"%S,%6N");
      k3s kubectl create -f ./replica-set.yaml;


      # ./run-test.bash >> ./result.txt;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-replica-set | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      sleep $v2;

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines < requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-replica-set | wc -l`;
      done;

      endTime=$(k3s kubectl logs --all-containers=true -l app=test-replica-set | sort -r | head -n 1);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";

      k3s kubectl delete ReplicaSet test-replica-set --grace-period=0 --force;
      k3s kubectl delete --all pods --grace-period=0 --force;

      sleep 3;

      cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-replica-set | sort -r | head -n 1 | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-replica-set | sort -r | head -n 1 | grep "not found"`;
      done;

      cd ..;
    done
  done
done