#!/bin/bash

variants1=(10);
variants2=(5 10);

variants=(1 5 10);
series=(1 2 3);

outputFile="result-minikube-set-image.txt";

for v1 in ${variants2[@]}; do
  for v2 in ${variants2[@]}; do
    cd ./"test-${v1}-${v2}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start apply run ${s}" >> ./"${outputFile}";

      ./start-test.bash;

      sleep 5;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      startTime=$(./update-apply.bash | head -n 1);

      # ./run-test.bash >> ./result.txt;


      sleep 5;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      endTime=$(../get-logs.bash);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      ../get-all-logs.bash >> ./"${outputFile}";

      ../clean-up.bash;

      sleep 3;

      cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;
      done;
    done

    echo "---------------------------------------------------" >> ./"${outputFile}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start script run ${s}" >> ./"${outputFile}";

      ./start-test.bash;

      sleep $v2;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      startTime=$(./update-script.bash | head -n 1);

      sleep 10;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        echo "${resultLines}, ${requiredAmountOfLines}"
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      endTime=$(../get-logs.bash);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      ../get-all-logs.bash >> ./"${outputFile}";

      ../clean-up.bash;

      sleep 3;

      cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;
      done;
    done

    echo "---------------------------------------------------" >> ./"${outputFile}";

    for s in ${series[@]}; do
      echo $v1;
      echo $v2;   

      echo "start set-image run ${s}" >> ./"${outputFile}";

      ./start-test.bash;

      sleep $v2;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "waiting for start-test to finish";
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      startTime=$(./update-set-image.bash | head -n 1);

      # ./run-test.bash >> ./result.txt;


      sleep 10;

      resultLines=`../get-all-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines != requiredAmountOfLines)); do
        echo "values ${resultLines} ${requiredAmountOfLines}";
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`../get-all-logs.bash | wc -l`;
      done;

      endTime=$(../get-logs.bash);

      echo "= ${endTime} - ${startTime}" >> ./"${outputFile}";
      echo "------------" >> ./"${outputFile}";
      ../get-all-logs.bash >> ./"${outputFile}";

      ../clean-up.bash;

      sleep 3;

      cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`../get-logs.bash | grep "No resources found in default namespace."`;
      done;
    done
    cd ..;
  done
done