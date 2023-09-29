#!/usr/bin/env bash

set -uox pipefail

mc rm -r --force minio/jhubgrpc-microstreamrawdata/channel_0
mc rm minio/jhubgrpc-microstreamrawdata/PersistenceTypeDictionary.ptd.0
mc mb minio/jhubgrpc-microstreamrawdata
./gradlew microstream-grpc-server:clean microstream-grpc-server:dockerBuild
kubectl delete -f microstream-grpc-server/k8s.yml
kubectl apply -f microstream-grpc-server/k8s.yml

# echo > "wait for server to startup for port forwarding"
sleep 60

microstream-grpc-server/portforwardserver.sh