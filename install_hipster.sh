#!/usr/bin/env bash

source ec_environment

echo ""
echo "Get the token from the Elastic > Integrations > APM > APM Agents > Node.js"
echo ""
read -p 'secretToken : ' SECRET_TOKEN
echo ""

OTEL_EXPORTER_OTLP_ENDPOINT="$EC_APM_URL:443"
OTEL_EXPORTER_OTLP_HEADERS="Bearer $SECRET_TOKEN"

echo "OTEL_EXPORTER_OTLP_ENDPOINT : $OTEL_EXPORTER_OTLP_ENDPOINT"
echo "OTEL_EXPORTER_OTLP_HEADERS  : $OTEL_EXPORTER_OTLP_HEADERS"

echo ""

read -p 'Press <Enter> to continue, Ctrl-C to cancel : ' PROCEED

mkdir -p ./.assets
rm -rf ./.assets/hipster
cp -r ./resources/opentelemetry-microservices-demo ./.assets/hipster
sed -i -e "s!OTEL_EXPORTER_OTLP_ENDPOINT!\"${OTEL_EXPORTER_OTLP_ENDPOINT}\"!" .assets/hipster/deploy-with-collector-k8s/otelcollector.yaml
sed -i -e "s!OTEL_EXPORTER_OTLP_HEADERS!\"${OTEL_EXPORTER_OTLP_HEADERS}\"!" .assets/hipster/deploy-with-collector-k8s/otelcollector.yaml

kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/adservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/redis.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/cartservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/checkoutservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/currencyservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/emailservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/frontend.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/paymentservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/productcatalogservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/recommendationservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/shippingservice.yaml
kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/loadgenerator.yaml

kubectl create -f ./.assets/hipster/deploy-with-collector-k8s/otelcollector.yaml

echo "$ kubectl get pods --namespace default"
kubectl get pods --namespace default
