#!/usr/bin/env bash

# This script restores the contents of a backup to its rightful PVCs.
# After the pods that perform the restore operation are "Completed",
# execute the '5_restore_files.sh' script,
# and after that the '6_delete_restore_pods.sh' script.

source scripts/environment.sh

# Restore MariaDB PVC
restic snapshots --json --last --path /data/mariadb-pvc | python scripts/customize.py mariadb | kubectl apply -f -

# Restore WordPress PVC
restic snapshots --json --last --path /data/wordpress-pvc | python scripts/customize.py wordpress | kubectl apply -f -
