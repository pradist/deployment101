#!/bin/bash
set -e

# Install Minikube and enable Ingress and Dashboard on Google Cloud Shell

echo "Starting Minikube with Docker driver and enabling Ingress..."
minikube start --driver=docker --addons=ingress

echo "Enabling Kubernetes Dashboard..."
minikube addons enable dashboard

echo "Waiting for dashboard pods to be ready..."
kubectl wait --for=condition=Ready pods --all -n kubernetes-dashboard --timeout=60s
echo "Getting Dashboard pods (namespace: kubernetes-dashboard)..."
kubectl get pods -n kubernetes-dashboard

echo "To access the dashboard, run the following command in a separate terminal:"
echo "kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8080:80"
