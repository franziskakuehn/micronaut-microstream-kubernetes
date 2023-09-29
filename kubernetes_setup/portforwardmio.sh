#!/usr/bin/env bash

set -euo pipefail

export POD_NAME=$(kubectl get pods --namespace hjava -l "release=minio" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 9000 --namespace hjava