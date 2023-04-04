terraform {
  required_version = ">= 1.0.0"

  required_providers {
    ec = {
      source  = "elastic/ec"
      version = "0.5.0"
    }
  }
}

provider "ec" {
  # an apikey must be provided, 
  # either by an override.tf file
  # or EC_API_KEY env var
  # or provide it here (uncomment and edit the following line)
  #apikey = "...my-api-key..."
}

resource "ec_deployment" "custom-deployment-id" {

  name                   = "autopilot-webinar"

  region                 = "gcp-us-west1"
  version                = "8.6.2"
  deployment_template_id = "gcp-memory-optimized-v2"

  elasticsearch {
    autoscale = "false"
  }

  kibana {}
  integrations_server {}

}

output "deployment_name" {
  value = ec_deployment.custom-deployment-id.name
}

output "elasticsearch_endpoint" {
  value = ec_deployment.custom-deployment-id.elasticsearch[0].https_endpoint
}

output "elasticsearch_cloud_id" {
  value = ec_deployment.custom-deployment-id.elasticsearch[0].cloud_id
}

output "elasticsearch_username" {
  value = ec_deployment.custom-deployment-id.elasticsearch_username
}

output "elasticsearch_password" {
  value = ec_deployment.custom-deployment-id.elasticsearch_password
  sensitive = true
}

output "kibana_endpoint" {
  value = ec_deployment.custom-deployment-id.kibana[0].https_endpoint
}

output "fleet_endpoint" {
  value = ec_deployment.custom-deployment-id.integrations_server[0].fleet_https_endpoint
}

output "apm_endpoint" {
  value = ec_deployment.custom-deployment-id.integrations_server[0].apm_https_endpoint
}
