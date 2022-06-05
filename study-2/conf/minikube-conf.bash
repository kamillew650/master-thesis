#!/bin/bash

minikube docker-env\n
export DOCKER_TLS_VERIFY="1"\n
export DOCKER_HOST="tcp://172.17.0.2:2376"\n
export DOCKER_CERT_PATH="/home/user/.minikube/certs"\n
export MINIKUBE_ACTIVE_DOCKERD="minikube"

eval $(minikube -p minikube docker-env)
