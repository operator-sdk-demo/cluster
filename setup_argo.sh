#!/bin/bash

k3d cluster create operator-sdk-demo -p "80:80@loadbalancer" -p "443:443@loadbalancer"

# Install argoCD
helm repo add argo https://argoproj.github.io/argo-helm
helm install argo arg/argo-cd --values argo.yaml --namespace argocd --wait --create-namespace --version 7.8.23

echo 'argo Password:'
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
echo ''

kubectl apply -n argocd -f application.yaml
