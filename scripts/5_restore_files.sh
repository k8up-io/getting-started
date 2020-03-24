#!/usr/bin/env bash

# This script restores the contents of a backup to the correct location
# inside a PVC.
# When the restore command executes, it saves the data in a folder named
# `data`; this script copies the `container_restore.sh` script into
# the pod, which finishes the restoration.
# Finally, it kills the MariaDB pod, so that the new files can be read properly
# (similar to restarting the database server after a restore.)
# The WordPress pod does not need restarting, since it's written in PHP.

source scripts/environment.sh

# MariaDB
MARIADB_POD=$(kubectl get pods | grep mariadb | awk '{print $1}')
kubectl cp scripts/container_restore.sh "$MARIADB_POD":/var/lib/mysql
kubectl exec "$MARIADB_POD" -- /var/lib/mysql/container_restore.sh mariadb
kubectl delete pod "$MARIADB_POD"

# Wordpress
WORDPRESS_POD=$(kubectl get pods | grep wordpress | awk '{print $1}')
kubectl cp scripts/container_restore.sh "$WORDPRESS_POD":/var/www/html
kubectl exec "$WORDPRESS_POD" -- /var/www/html/container_restore.sh wordpress
