#!/usr/bin/env bash

# This script rebuilds the complete SKS cluster in one shot,
# creating a ready-to-use WordPress + MariaDB + Minio environment.

echo ""
echo "••• Terraforming Exoscale •••"
cd scripts && terraform init && terraform apply -auto-approve

# Export Kubeconfig from Exoscale
exo sks kubeconfig K8s-getting-started user -z ch-gva-2 --group system:masters > exoscale-sks.kubeconfig && cd ..

# Set kubectl context
export KUBECONFIG="./scripts/exoscale-sks.kubeconfig"

echo ""
echo "••• Waiting 5 minutes for cluster to be ready •••"
sleep 300

echo ""
echo "••• Installing Longhorn storage controller •••"
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.1.1/deploy/longhorn.yaml

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
kubectl apply -f https://github.com/k8up-io/k8up/releases/download/v1.2.0/k8up-crd.yaml
helm repo add appuio https://charts.appuio.ch
helm repo update
helm install k8up appuio/k8up --namespace k8up-operator --create-namespace

echo ""
echo "••• Done! Use kubectl or k9s to use your cluster •••"
