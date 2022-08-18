#!/bin/bash

kubectl logs --all-containers=true -l app=test-deployment-update | sort -r | head -n 1;