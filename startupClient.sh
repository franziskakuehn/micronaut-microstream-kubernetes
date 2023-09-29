#!/usr/bin/env bash

set -uox pipefail

mc rm -r --force minio/jhubgrpc-datapageview/channel_0
mc rm minio/jhubgrpc-datapageview/PersistenceTypeDictionary.ptd.0
mc mb minio/jhubgrpc-datapageview

mc rm -r --force minio/jhubgrpc-dataviewtime/channel_0
mc rm minio/jhubgrpc-dataviewtime/PersistenceTypeDictionary.ptd.0
mc mb minio/jhubgrpc-dataviewtime

./gradlew microstream-grpc-client:clean microstream-grpc-client:dockerBuild
kubectl delete -f microstream-grpc-client/k8s.yml
kubectl apply -f microstream-grpc-client/k8s.yml

# echo > "wait for client to startup for port forwarding"
sleep 60

microstream-grpc-client/portforwardclient.sh
