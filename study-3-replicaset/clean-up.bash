#!/bin/bash

kubectl delete ReplicaSet test-replica-set --grace-period=0 --force;
kubectl delete --all pods --grace-period=0 --force;