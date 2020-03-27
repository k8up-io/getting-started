#!/usr/bin/env bash

# This script triggers a backup job

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

# Trigger backup
kubectl apply -f k8up/backup.yaml
