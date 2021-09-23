#!/usr/bin/env bash

echo "Wordpress: $(minikube service wordpress --url)"
echo "Minio Console: $(minikube service minio-console --url)"
