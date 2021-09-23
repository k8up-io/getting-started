#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

echo "Wordpress: http://$(kubectl get services | grep wordpress | awk '{print $4}' | cut -f 1 -d ","):8080"
echo "Minio Console: http://$(kubectl get services | grep minio-console | awk '{print $4}' | cut -f 1 -d ","):9001"

