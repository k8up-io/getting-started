export RESTIC_REPOSITORY=s3:$(minikube service minio-api --url)/backups/
export RESTIC_PASSWORD=p@ssw0rd
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio123
