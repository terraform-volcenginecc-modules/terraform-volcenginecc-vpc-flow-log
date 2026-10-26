output "flow_log_ids" {
  description = "Flow log IDs keyed by the same stable keys as flow_logs."
  value = {
    for key, flow_log in volcenginecc_vpc_flow_log.this : key => flow_log.flow_log_id
  }
}

output "flow_logs" {
  description = "Provider-reported flow log metadata keyed by the same stable keys as flow_logs."
  value = {
    for key, flow_log in volcenginecc_vpc_flow_log.this : key => {
      flow_log_id     = flow_log.flow_log_id
      flow_log_name   = flow_log.flow_log_name
      log_project_id  = flow_log.log_project_id
      log_topic_id    = flow_log.log_topic_id
      resource_id     = flow_log.resource_id
      resource_type   = flow_log.resource_type
      status          = flow_log.status
      traffic_type    = flow_log.traffic_type
      vpc_id          = flow_log.vpc_id
      enable_index    = flow_log.enable_index
      business_status = flow_log.business_status
      created_at      = flow_log.created_at
    }
  }
}
