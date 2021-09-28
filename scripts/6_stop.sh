#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

# Remove Kubernetes objects
kubectl delete -k mariadb
kubectl delete -k wordpress
kubectl delete -k secrets

# Remove SKS cluster
cd scripts
terraform destroy
cd ..

# Delete Exoscale Object Storage bucket
exo storage rb sos://backups-getting-started-repo --force --recursive
