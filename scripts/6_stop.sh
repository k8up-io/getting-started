#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

kubectl delete -k mariadb
kubectl delete -k wordpress
kubectl delete -k secrets

cd scripts
terraform destroy
cd ..
