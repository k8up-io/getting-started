#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

cd scripts
terraform destroy
cd ..
