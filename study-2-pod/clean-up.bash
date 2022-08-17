#!/bin/bash

kubectl delete --all pods --grace-period=0 --force;
