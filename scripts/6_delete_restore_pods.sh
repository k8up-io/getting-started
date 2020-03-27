#!/usr/bin/env bash

# This script deletes the restore pods created by '4_restore_pvc.sh'

source scripts/environment.sh

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

# MariaDB
restic snapshots --json --last --path /data/mariadb-pvc | python scripts/customize.py mariadb | kubectl delete -f -

# WordPress
restic snapshots --json --last --path /data/wordpress-pvc | python scripts/customize.py wordpress | kubectl delete -f -
