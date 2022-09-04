#!/bin/bash

variants1=(10);
variants2=(5 10);

variants=(1 5 10);
series=(1 2 3);

outputFile="result-k3s.txt";

for v1 in ${variants[@]}; do
  for v2 in ${variants[@]}; do
    cd ./"test-${v1}-${v2}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start apply run ${s}" >> ./"${outputFile}";

      k3s kubectl create -f ./deployment-v1.yaml;

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      startTime=$(date +"%S,%6N");
      k3s kubectl apply -f ./deployment-v2.yaml;

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      endTime=$(k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      k3s kubectl logs --all-containers=true -l app=test-deployment-update >> ./"${outputFile}";

      k3s kubectl delete Deployment test-deployment-update --grace-period=0 --force;
      k3s kubectl delete --all pods --grace-period=0 --force;

      sleep 3;

      cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;
      done;
    done

    echo "---------------------------------------------------" >> ./"${outputFile}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start apply run ${s}" >> ./"${outputFile}";

      k3s kubectl create -f ./deployment-v1.yaml;

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      startTime=$(date +"%S,%6N");
      k3s kubectl delete Deployment test-deployment-update --grace-period=0 --force;
      k3s kubectl delete --all pods --grace-period=0 --force;

      while ($(kubectl get Deployment | grep -q 'test-deployment-update') )
      do
        echo 'not ready';
      done
      k3s kubectl create -f ./deployment-v2.yaml;

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      endTime=$(k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      k3s kubectl logs --all-containers=true -l app=test-deployment-update >> ./"${outputFile}";

      k3s kubectl delete Deployment test-deployment-update --grace-period=0 --force;
      k3s kubectl delete --all pods --grace-period=0 --force;

      sleep 3;

      cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;
      done;
    done

    echo "---------------------------------------------------" >> ./"${outputFile}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start apply run ${s}" >> ./"${outputFile}";

      k3s kubectl create -f ./deployment-v1.yaml;

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      startTime=$(date +"%S,%6N");
      if [[ "$v2" -eq 1 ]]; then
        k3s kubectl set image deployment/test-deployment-update container-1=deployment:2;
      fi
      if [[ "$v2" -eq 5 ]]; then
        k3s kubectl set image deployment/test-deployment-update container-1=deployment:2 container-2=deployment:2 container-3=deployment:2 container-4=deployment:2 container-5=deployment:2;
      fi
      if [[ "$v2" -eq 10 ]]; then
        k3s kubectl set image deployment/test-deployment-update container-1=deployment:2 container-2=deployment:2 container-3=deployment:2 container-4=deployment:2 container-5=deployment:2 container-6=deployment:2 container-7=deployment:2 container-8=deployment:2 container-9=deployment:2 container-10=deployment:2;
      fi

      sleep 5;

      resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | wc -l`;
      done;

      endTime=$(k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      k3s kubectl logs --all-containers=true -l app=test-deployment-update >> ./"${outputFile}";

      k3s kubectl delete Deployment test-deployment-update --grace-period=0 --force;
      k3s kubectl delete --all pods --grace-period=0 --force;

      sleep 3;

      cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`k3s kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1 | grep "not found"`;
      done;
    done
    cd ..;
  done
done