output "flow_log_ids" {
  description = "IDs of the subnet rejected-traffic and ENI all-traffic flow logs."
  value = merge(
    module.subnet_flow_log.flow_log_ids,
    module.eni_flow_log.flow_log_ids,
  )
}

output "flow_logs" {
  description = "Provider-reported metadata for the created flow logs."
  value = merge(
    module.subnet_flow_log.flow_logs,
    module.eni_flow_log.flow_logs,
  )
}

output "log_project" {
  description = "Created Log Service project receiving the Flow Logs."
  value = {
    id   = volcenginecc_tls_project.flow_log.project_id
    name = volcenginecc_tls_project.flow_log.project_name
  }
}

output "log_topic" {
  description = "Created Log Service topic and retention policy receiving the Flow Logs."
  value = {
    id             = volcenginecc_tls_topic.flow_log.topic_id
    name           = volcenginecc_tls_topic.flow_log.topic_name
    retention_days = volcenginecc_tls_topic.flow_log.ttl
    shard_count    = volcenginecc_tls_topic.flow_log.shard_count
  }
}

output "log_index" {
  description = "Full-text and automatic-field index configured for the Log Service topic."
  value = {
    automatic_field_index = volcenginecc_tls_index.flow_log.enable_auto_index
    full_text             = volcenginecc_tls_index.flow_log.full_text
    topic_id              = volcenginecc_tls_index.flow_log.topic_id
  }
}

output "tos_delivery" {
  description = "Enabled TLS shipper delivering the Log Service topic to TOS."
  value = {
    bucket_name  = var.tos_bucket_name
    shipper_id   = volcenginecc_tls_shipper.tos.shipper_id
    shipper_name = volcenginecc_tls_shipper.tos.shipper_name
    status       = volcenginecc_tls_shipper.tos.status
    topic_id     = volcenginecc_tls_shipper.tos.topic_id
  }
}
