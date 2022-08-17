#!/bin/bash

kubectl logs --all-containers=true -l app=test-deployment | sort -r | head -n 1;