provider "volcenginecc" {
  region = var.region
}

resource "volcenginecc_tls_project" "flow_log" {
  project_name     = var.log_project_name
  description      = "Terraform VPC Flow Log basic validation"
  iam_project_name = var.iam_project_name
}

resource "volcenginecc_tls_topic" "flow_log" {
  project_id    = volcenginecc_tls_project.flow_log.project_id
  topic_name    = var.log_topic_name
  shard_count   = 1
  ttl           = var.log_retention_days
  description   = "VPC Flow Log all traffic"
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

module "vpc_flow_log" {
  source  = "terraform-volcenginecc-modules/vpc-flow-log/volcenginecc"
  version = "~> 1.0"

  flow_logs = {
    vpc_all_traffic = {
      flow_log_name    = var.flow_log_name
      log_project_name = volcenginecc_tls_project.flow_log.project_name
      log_topic_name   = volcenginecc_tls_topic.flow_log.topic_name
      resource_id      = var.vpc_id
      resource_type    = "vpc"
      traffic_type     = "All"

      tags = {
        Environment = "example"
        ManagedBy   = "Terraform"
      }
    }
  }

  depends_on = [volcenginecc_tls_index.flow_log]
}
