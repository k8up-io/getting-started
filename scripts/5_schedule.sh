#!/usr/bin/env bash

source scripts/environment.sh

# Set kubectl context
export KUBECONFIG="$(k3d kubeconfig write k8s-tutorial)"

# Set the schedule
kubectl apply -f k8up/schedule.yaml

# Watch how the number of snapshots grow
watch restic snapshots
