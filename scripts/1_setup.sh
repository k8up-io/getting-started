#!/usr/bin/env bash

# This script rebuilds the complete minikube cluster in one shot,
# creating a ready-to-use WordPress + MariaDB + Minio environment.

echo ""
echo "••• Launching minikube •••"
minikube start --nodes=2 --cpus='2' --memory='3g'

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
