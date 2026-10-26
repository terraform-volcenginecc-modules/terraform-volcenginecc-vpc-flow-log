provider "volcenginecc" {
  region = var.region
}

resource "volcenginecc_tls_project" "flow_log" {
  project_name     = var.log_project_name
  description      = "Terraform VPC Flow Log complete validation"
  iam_project_name = var.iam_project_name
}

resource "volcenginecc_tls_topic" "flow_log" {
  project_id    = volcenginecc_tls_project.flow_log.project_id
  topic_name    = var.log_topic_name
  shard_count   = 1
  ttl           = var.log_retention_days
  description   = "VPC Flow Log complete delivery"
  allow_consume = false
}

resource "volcenginecc_tls_index" "flow_log" {
  topic_id          = volcenginecc_tls_topic.flow_log.topic_id
  enable_auto_index = true
  max_text_len      = 2048

  full_text = {
    case_sensitive = false
    delimiter = chomp(<<-EOT
    , '";$#!=()[]{}?@&<>/:\n\t\r\\%*+-._^`|~QWE
    EOT
    )
    include_chinese = true
  }
}

resource "volcenginecc_tls_shipper" "tos" {
  topic_id     = volcenginecc_tls_topic.flow_log.topic_id
  shipper_name = var.shipper_name
  shipper_type = "tos"
  status       = true

  content_info = {
    format = "jsonl"
    json_info = {
      enable = true
      escape = true
    }
  }

  tos_shipper_info = {
    bucket           = var.tos_bucket_name
    compress         = "gzip"
    interval         = 300
    max_size         = 5
    partition_format = "%Y/%m/%d/%H"
    prefix           = "vpc-flow-log"
  }
}

module "subnet_flow_log" {
  source  = "terraform-volcenginecc-modules/vpc-flow-log/volcenginecc"
  version = "~> 1.0"

  flow_logs = {
    subnet_rejected_traffic = {
      aggregation_interval = 1
      description          = "Security audit for rejected subnet traffic"
      flow_log_name        = var.subnet_flow_log_name
      log_project_name     = volcenginecc_tls_project.flow_log.project_name
      log_topic_name       = volcenginecc_tls_topic.flow_log.topic_name
      project_name         = var.project_name
      resource_id          = var.subnet_id
      resource_type        = "subnet"
      traffic_type         = "Drop"

      tags = {
        Environment = "example"
        ManagedBy   = "Terraform"
        Purpose     = "security-audit"
      }
    }
  }

  depends_on = [volcenginecc_tls_index.flow_log]
}

module "eni_flow_log" {
  source  = "terraform-volcenginecc-modules/vpc-flow-log/volcenginecc"
  version = "~> 1.0"

  flow_logs = {
    eni_all_traffic = {
      aggregation_interval = 5
      description          = "Network troubleshooting for an ENI"
      flow_log_name        = var.eni_flow_log_name
      log_project_name     = volcenginecc_tls_project.flow_log.project_name
      log_topic_name       = volcenginecc_tls_topic.flow_log.topic_name
      project_name         = var.project_name
      resource_id          = var.eni_id
      resource_type        = "eni"
      traffic_type         = "All"

      tags = {
        Environment = "example"
        ManagedBy   = "Terraform"
        Purpose     = "network-troubleshooting"
      }
    }
  }

  # The VPC service rejects concurrent Flow Log create requests for one VPC.
  depends_on = [module.subnet_flow_log]
}
