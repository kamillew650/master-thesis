#!/bin/bash

echo $(date +"%S,%6N");
kubectl apply -f ./deployment-v2.yaml;

