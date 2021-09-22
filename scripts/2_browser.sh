#!/usr/bin/env bash

# Set kubectl context
export KUBECONFIG="$(k3d kubeconfig write k8s-tutorial)"

case $(uname -s) in
    "Linux")
        echo "Wordpress: http://$(kubectl get services | grep wordpress | awk '{print $4}' | cut -f 1 -d ","):8080"
        echo "Minio Console: http://$(kubectl get services | grep minio-console | awk '{print $4}' | cut -f 1 -d ","):9001"
    ;;
    "Darwin")
        # In macOS, Docker is behind a VM without port mapping
        kubectl port-forward service/wordpress 8080:8080 &
        kubectl port-forward service/minio 9001:9001 &
        echo "Wordpress: http://localhost:8080"
        echo "Minio: http://localhost:9001"
    ;;
esac
