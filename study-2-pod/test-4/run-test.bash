#!/bin/bash

echo $(date +"%T.%6N");
kubectl create -f ./test.yaml;
