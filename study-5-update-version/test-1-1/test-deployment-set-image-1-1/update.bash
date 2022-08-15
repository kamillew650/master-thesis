#!/bin/bash

echo $(date +"%T.%6N");
kubectl set image deployment/deployment-update container=deployment:2


