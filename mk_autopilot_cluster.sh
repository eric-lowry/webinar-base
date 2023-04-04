#!/usr/bin/env bash

source ./gke_environment

echo "Deploying Cluster:"
echo "$PROJECT/$REGION/$CLUSTER_NAME/$CLUSTER_VERSION"

# set the project
gcloud config set project $PROJECT

# create the cluster
#gcloud container clusters create $CLUSTER_NAME \
#    --release-channel "rapid" \
#    --cluster-version $CLUSTER_VERSION \
#    --region $REGION

gcloud beta container --project "$PROJECT" clusters create "$CLUSTER_NAME" \
    --zone "$REGION" --num-nodes "5" \
    --no-enable-basic-auth \
    --cluster-version "$CLUSTER_VERSION" --release-channel "None" \
    --machine-type "e2-medium" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" \
    --disk-size "100" --metadata disable-legacy-endpoints=true \
    --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --max-pods-per-node "110" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM --enable-ip-alias \
    --network "projects/elastic-sa/global/networks/default" --no-enable-intra-node-visibility \
    --default-max-pods-per-node "110" \
    --no-enable-master-authorized-networks \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
    --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 \
    --max-unavailable-upgrade 0 --enable-shielded-nodes \
    --node-locations "$REGION"

# add labels to the cluster
gcloud container clusters update $CLUSTER_NAME \
    --region $REGION \
    --update-labels=$CLUSTER_LABELS

echo ""
echo "Now add kube state metrics to the cluster:"
echo ""
echo "kubectl apply -f ./resources/kube-state-metrics/examples/standard"
