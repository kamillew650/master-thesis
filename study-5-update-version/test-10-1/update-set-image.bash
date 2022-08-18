#!/bin/bash

echo $(date +"%S,%6N");
kubectl set image deployment/test-deployment-update container=deployment:2


