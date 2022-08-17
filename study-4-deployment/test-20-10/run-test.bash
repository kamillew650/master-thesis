#!/bin/bash

echo $(date +"%S,%6N");
kubectl create -f ./deployment.yaml | head -n 1;

