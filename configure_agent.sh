#!/usr/bin/env bash

source ./gke_environment
source ./ec_environment

clear

echo ""
echo ""
echo "Configuring Elastic Agent for Google GKE Autopilot cluster"
echo ""

echo "Cluster: $CLUSTER_NAME"
echo ""

FLEET_URL="$EC_FLEET_URL:443"

echo    "FLEET_URL              : $FLEET_URL"
read -p 'FLEET_ENROLLMENT_TOKEN : ' FLEET_ENROLLMENT_TOKEN

mkdir -p ./.assets
rm -rf ./.assets/elastic-agent-managed-gke-autopilot.yaml 
cp ./resources/elastic-agent-managed-kubernetes.yaml ./.assets/elastic-agent-managed-gke-autopilot.yaml
sed -i -e "s!value: \"FLEET_URL\"!value: \"$FLEET_URL\"!" .assets/elastic-agent-managed-gke-autopilot.yaml
sed -i -e "s!value: \"FLEET_ENROLLMENT_TOKEN\"!value: \"$FLEET_ENROLLMENT_TOKEN\"!" .assets/elastic-agent-managed-gke-autopilot.yaml

clear

echo ""
echo "Elastic Agent manifest is ready to install into $CLUSTER_NAME"
echo ""
echo "Please run:"
echo ""
#echo "kubectl --dry-run=\"client\" apply -f .assets/elastic-agent-managed-gke-autopilot.yaml"
echo "kubectl apply -f .assets/elastic-agent-managed-gke-autopilot.yaml"
echo ""
