#!/bin/bash

kubectl logs --all-containers=true -l app=test-replica-set | sort -r | head -n 1;