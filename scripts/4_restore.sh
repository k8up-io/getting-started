#!/usr/bin/env bash

# This script restores the contents of a backup to its rightful PVCs.
# After the pods that perform the restore operation are "Completed",
# execute the '5_restore_files.sh' script,
# and after that the '6_delete_restore_pods.sh' script.

source scripts/environment.sh

# Set kubectl context
export KUBECONFIG="$(k3d kubeconfig write k8s-tutorial)"

# Restore WordPress PVC
# By default, the YAML file references the latest snapshot
kubectl apply -f k8up/restore-wordpress.yaml

# Read SQL data from Restic into file
SNAPSHOT_ID=$(restic snapshots --json --latest 1 --path /default-mariadb | jq -r '.[0].id')
restic dump "${SNAPSHOT_ID}" /default-mariadb > backup.sql

# Restore MariaDB data
MARIADB_POD=$(kubectl get pods | grep mariadb | awk '{print $1}')
kubectl cp backup.sql "$MARIADB_POD":/
kubectl cp scripts/db_restore.sh "$MARIADB_POD":/
kubectl exec "$MARIADB_POD" -- /db_restore.sh
