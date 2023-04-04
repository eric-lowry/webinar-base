#!/usr/bin/env bash
source ./gke_environment
echo ""
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT
echo ""
echo "kubectl config current-context :"
kubectl config current-context
echo ""
