#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

case $(uname -s) in
    "Linux")
        echo "Wordpress: http://$(kubectl get services | grep wordpress | awk '{print $4}'):8080"
        echo "Minio: http://$(kubectl get services | grep minio | awk '{print $4}'):9000"
    ;;
    "Darwin")
        # In macOS, Docker is behind a VM without port mapping
        kubectl port-forward service/wordpress 8080:8080 &
        kubectl port-forward service/minio 9000:9000 &
        echo "Wordpress: http://localhost:8080"
        echo "Minio: http://localhost:9000"
    ;;
esac
