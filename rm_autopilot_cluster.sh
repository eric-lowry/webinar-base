#!/usr/bin/env bash

source ./gke_environment

echo "Deleting Cluster:"
echo "$PROJECT/$REGION/$CLUSTER_NAME/$CLUSTER_VERSION"

# create the cluster
gcloud container clusters --region $REGION delete $CLUSTER_NAME
