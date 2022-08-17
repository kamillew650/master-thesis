#!/bin/bash

# kubectl logs test-pod;
kubectl logs --all-containers=true test-pod  | sort -r | head -n 1;