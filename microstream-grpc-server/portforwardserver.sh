#!/usr/bin/env bash

set -euo pipefail

export POD_NAME=$(kubectl get pods --namespace hjava -l "release=microstream-grpc-server" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 5050 --namespace hjava

