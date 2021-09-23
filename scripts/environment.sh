export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"
export RESTIC_REPOSITORY=s3:http://$(kubectl get services | grep minio-api | awk '{print $4}' | cut -f 1 -d ","):9000/backups/
export RESTIC_PASSWORD=p@ssw0rd
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio123
