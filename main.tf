locals {
  normalized_flow_logs = {
    for key, flow_log in var.flow_logs : key => merge(flow_log, {
      tags = flow_log.tags == null ? null : [
        for tag_key in sort(keys(flow_log.tags)) : {
          key   = tag_key
          value = flow_log.tags[tag_key]
        }
      ]
    })
  }
}

resource "volcenginecc_vpc_flow_log" "this" {
  for_each = local.normalized_flow_logs

  aggregation_interval = each.value.aggregation_interval
  description          = each.value.description
  flow_log_name        = each.value.flow_log_name
  log_project_name     = each.value.log_project_name
  log_topic_name       = each.value.log_topic_name
  project_name         = each.value.project_name
  resource_id          = each.value.resource_id
  resource_type        = each.value.resource_type
  status               = each.value.status
  tags                 = each.value.tags
  traffic_type         = each.value.traffic_type
}
