#!/bin/bash

echo $(gdate +"%T.%6N");
kubectl set image deployment/deployment-update container=deployment:2


