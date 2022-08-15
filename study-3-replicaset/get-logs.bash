#!/bin/bash

kubectl logs --all-containers=true -l app=test-replica-set;