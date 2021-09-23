#!/usr/bin/env bash

source scripts/environment.sh

# Set the schedule
kubectl apply -f k8up/schedule.yaml

# Watch how the number of snapshots grow
watch restic snapshots
