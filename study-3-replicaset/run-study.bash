#!/bin/bash

variants=(1 5 10 20)
series=(1 2 3)

for v1 in ${variants[@]}; do
  for v2 in ${variants[@]}; do
    for s in ${series[@]}; do
    
      echo $v1;
      echo $v2;
      cd ./"test-${v1}-${v2}";

      echo "start run ${s}" >> ./result.txt;
      ./run-test.bash >> ./result.txt;
      echo "end" >> ./result.txt;

      resultLines=`../get-logs.bash | wc -l`;
      requiredAmountOfLines=$(($v1 * $v2));

      sleep $requiredAmountOfLines;

      echo $resultLines;
      echo $requiredAmountOfLines;
      while ((resultLines < requiredAmountOfLines)); do
        echo "waiting for get-logs to finish";
        sleep 5s;
        resultLines=`../get-logs.bash | wc -l`;
      done;

      ../get-logs.bash >> ./result.txt;

      ../clean-up.bash;

      sleep 3;

      cleanUpResult=`./get-logs.bash | grep "not found"`;

      while ! $cleanUpResult; do
        echo "waiting for clean-up to finish";
        sleep 1;
        cleanUpResult=`./ge-logs.bash | grep "not found"`;
      done;

      cd ..;
    done
  done
done