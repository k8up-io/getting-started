#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

# Remove Kubernetes objects
kubectl delete -k wordpress --wait=false
kubectl delete -k mariadb --wait=false
kubectl delete -k secrets --wait=false

# Remove SKS cluster
cd scripts
terraform destroy
cd ..

# Delete Exoscale Object Storage bucket
exo storage rb sos://backups-getting-started-repo --force --recursive
