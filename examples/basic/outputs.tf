output "flow_log_id" {
  description = "ID of the flow log collecting all VPC traffic."
  value       = module.vpc_flow_log.flow_log_ids["vpc_all_traffic"]
}

output "log_project" {
  description = "Created Log Service project receiving the flow log."
  value = {
    id   = volcenginecc_tls_project.flow_log.project_id
    name = volcenginecc_tls_project.flow_log.project_name
  }
}

output "log_topic" {
  description = "Created Log Service topic and retention policy receiving the flow log."
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

output "flow_log" {
  description = "Provider-reported Flow Log target and delivery metadata."
  value       = module.vpc_flow_log.flow_logs["vpc_all_traffic"]
}
