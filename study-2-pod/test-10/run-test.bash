#!/bin/bash

echo $(date +"%S,%6N");
kubectl create -f ./test.yaml;

