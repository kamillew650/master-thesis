#!/bin/bash

kubectl delete pod test-pod --grace-period=0 --force;