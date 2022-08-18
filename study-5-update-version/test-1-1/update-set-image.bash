#!/bin/bash

echo $(date +"%S,%6N");
kubectl set image deployment/test-deployment-update container-1=deployment:2;


