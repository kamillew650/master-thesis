
#!/bin/bash

variants=(1 5 10 20);
variants1=(10);
variants2=(5);


series=(1 2 3);

outputFile="result-kind-2.txt";


for v1 in ${variants1[@]}; do
  for v2 in ${variants2[@]}; do
    for s in ${series[@]}; do
    
      echo $v1;
      echo $v2;
      cd ./"test-${v1}-${v2}";

      echo "start run ${s}" >> ./"${outputFile}";

      startTime=$(date +"%s,%6N");
      kubectl create -f ./deployment.yaml;

      resultLines=`kubectl logs --all-containers=true -l app=test-deployment | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      sleep $v2;

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines < requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`kubectl logs --all-containers=true -l app=test-deployment | wc -l`;
      done;

      endTime=$(kubectl logs --all-containers=true -l app=test-deployment | sort -r | head -n 1);
      allLogs=$(kubectl logs --all-containers=true -l app=test-replica-set | sort -r);


      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "-------------------------------------------------" >> ./"${outputFile}";
      echo "${allLogs}" >> ./"${outputFile}";

      kubectl delete Deployment test-deployment --grace-period=0 --force;
      kubectl delete --all pods --grace-period=0 --force;

      sleep 3;

      cleanUpResult=`kubectl logs --all-containers=true -l app=test-deployment | sort -r | head -n 1 | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`kubectl logs --all-containers=true -l app=test-deployment | sort -r | head -n 1 | grep "not found"`;
      done;

      cd ..;
    done
  done
done