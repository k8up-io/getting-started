#!/usr/bin/env bash

# This script triggers a backup job

# Set kubectl context
export KUBECONFIG="$(k3d kubeconfig write k8s-tutorial)"

# Trigger backup
kubectl apply -f k8up/backup.yaml
