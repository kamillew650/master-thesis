#!/bin/bash

kubectl delete Deployment test-deployment --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;