#!/bin/bash

echo $(date +"%Y-%m-%dT%H:%M:%S%z");
kubectl create -f ./test.yaml;

