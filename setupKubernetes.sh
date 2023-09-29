#!/usr/bin/env bash

set -euo pipefail

HELM=${HELM:-helm}

JHUB_NAMESPACE=${JHUB_NAMESPACE:-hjava}

create_namespace() {
  # Create the vvp system and jobs namespaces if they do not exist
  kubectl get namespace "$JHUB_NAMESPACE" > /dev/null 2>&1 || kubectl create namespace "$JHUB_NAMESPACE"
}

helm_install() {
  local name chart namespace

  name="$1"; shift
  chart="$1"; shift
  namespace="$1"; shift

  $HELM \
    --namespace "$namespace" \
    upgrade --install "$name" "$chart" \
    "$@"
}

install_minio() {
  helm_install minio minio "$JHUB_NAMESPACE" \
    --repo https://helm.min.io \
    --values kubernetes_setup/values-minio.yaml
}

delete_all(){
  helm uninstall minio -n "$JHUB_NAMESPACE"
  helm uninstall confluent-operator -n "$JHUB_NAMESPACE"
  kubectl delete -f kubernetes_setup/confluent-platform.yaml -n "$JHUB_NAMESPACE"
  kubectl delete -f kubernetes_setup/connector.yaml -n "$JHUB_NAMESPACE"
  kubectl delete -f kubernetes_setup/auth.yaml -n "$JHUB_NAMESPACE"
  kubectl delete namespaces "$JHUB_NAMESPACE"
}

install_confluent() {
  # https://docs.confluent.io/operator/current/co-deploy-cfk.html
  # git clone https://github.com/Platformatory/confluent-kubernetes-examples.git
  helm repo add confluentinc https://packages.confluent.io/helm
  sed -i "s/namespace: hjava/namespace: $JHUB_NAMESPACE/g" kubernetes_setup/confluent-platform.yaml  
  sed -i "s/namespace: hjava/namespace: $JHUB_NAMESPACE/g" kubernetes_setup/connector.yaml 
  sed -i "s/namespace: hjava/namespace: $JHUB_NAMESPACE/g" kubernetes_setup/auth.yaml 
  helm_install confluent-operator confluentinc/confluent-for-kubernetes "$JHUB_NAMESPACE" 
  # sleep 120
  kubectl apply -f kubernetes_setup/confluent-platform.yaml -n "$JHUB_NAMESPACE"
  sleep 300
  kubectl apply -f kubernetes_setup/connector.yaml -n "$JHUB_NAMESPACE"
}

main(){
    # helm repo add confluentinc https://packages.confluent.io/helm
    # helm repo update

    # echo "> Creating Kubernetes namespaces..."
    create_namespace

    # echo "> Installing MinIO..."
    install_minio || :

    # echo "> Installing Confluent..."
    install_confluent || :
    
    # echo "> Installing Service Account"
    
    kubectl apply -f kubernetes_setup/auth.yaml -n "$JHUB_NAMESPACE"    

    # echo "> Delete everything..."
    # delete_all || :

}

main "$@"