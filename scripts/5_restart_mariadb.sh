#!/usr/bin/env bash

# This script restarts mariadb so it will load the restored database.

source scripts/environment.sh

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

# Restart mariadb
kubectl delete pod "$(kubectl get pods | grep mariadb | awk '{print $1}')"
