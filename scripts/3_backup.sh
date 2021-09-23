#!/usr/bin/env bash

# This script triggers a backup job

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

# Trigger backup
kubectl apply -f k8up/backup.yaml
