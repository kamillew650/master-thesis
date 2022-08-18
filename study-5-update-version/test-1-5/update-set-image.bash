#!/bin/bash

echo $(date +"%S,%6N");
kubectl set image deployment/deployment-update container=deployment:2


