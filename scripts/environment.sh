export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
export RESTIC_REPOSITORY=s3:http://$(kubectl get services | grep minio | awk '{print $4}'):9000/backups/
export RESTIC_PASSWORD=p@ssw0rd
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio123
