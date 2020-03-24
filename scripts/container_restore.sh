#!/usr/bin/env sh

# This script restores the contents of a backup to its rightful place
# It is copied into a running pod and executed inside it
# by the `3_restore_files.sh` script.

echo "Restoring files in $1 pod"
if [ "$1" = "mariadb" ]; then
    cd /var/lib/mysql
else
    cd /var/www/html
fi
pwd

# Move the data to the root of the PVC
mv data /

# Remove everything and just copy the contents of the backup
# (this will also remove this very script!)
rm -r *
cp -R /data/"$1"-pvc/* .

# Clean everything up
rm -rf /data
