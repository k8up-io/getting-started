#!/usr/bin/env bash

kubectl apply -f k8up/schedule.yaml

source scripts/environment.sh

watch restic snapshots
