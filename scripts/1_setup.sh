#!/usr/bin/env bash

# This script rebuilds the complete k3d cluster in one shot,
# creating a ready-to-use WordPress + MariaDB + Minio environment.

echo ""
echo "••• Launching k3d •••"
k3d create

# Wait for startup
sleep 50

# Set kubectl context
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
kubectl cluster-info

echo ""
echo "••• Installing Secrets •••"
kubectl apply -k secrets

echo ""
echo "••• Installing Minio •••"
kubectl apply -k minio

echo ""
echo "••• Installing MariaDB •••"
kubectl apply -k mariadb

echo ""
echo "••• Installing WordPress •••"
kubectl apply -k wordpress

echo ""
echo "••• Installing K8up •••"
helm repo add appuio https://charts.appuio.ch
helm repo update
helm install appuio/k8up --generate-name --set k8up.backupImage.tag=v0.1.8-root

echo ""
echo "••• Watch pods •••"
k9s
