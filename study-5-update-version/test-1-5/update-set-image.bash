#!/bin/bash

echo $(date +"%S,%6N");
kubectl set image deployment/test-deployment-update container-1=deployment:2 container-1=deployment:2 container-2=deployment:2 container-3=deployment:2 container-4=deployment:2 container-5=deployment:2


