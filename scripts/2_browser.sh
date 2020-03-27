#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

echo "Wordpress: http://$(kubectl get services | grep wordpress | awk '{print $4}'):8080"
echo "Minio: http://$(kubectl get services | grep minio | awk '{print $4}'):9000"
