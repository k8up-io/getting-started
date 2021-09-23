#!/usr/bin/env bash

source scripts/environment.sh

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

# Set the schedule
kubectl apply -f k8up/schedule.yaml

# Watch how the number of snapshots grow
watch restic snapshots
