variable "flow_logs" {
  description = "Non-empty map of VPC flow logs keyed by stable logical names. Each log targets one existing VPC, subnet, or ENI and one existing Log Service project/topic."
  type = map(object({
    aggregation_interval = optional(number, 10)
    description          = optional(string)
    flow_log_name        = string
    log_project_name     = string
    log_topic_name       = string
    project_name         = optional(string)
    resource_id          = string
    resource_type        = string
    status               = optional(string, "Active")
    tags                 = optional(map(string))
    traffic_type         = optional(string, "All")
  }))
  nullable = false

  validation {
    condition     = length(var.flow_logs) > 0
    error_message = "flow_logs must contain at least one flow log."
  }

  validation {
    condition = alltrue([
      for key in keys(var.flow_logs) : trimspace(key) != ""
    ])
    error_message = "flow_logs keys must not be empty."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      contains([1, 5, 10], flow_log.aggregation_interval)
    ])
    error_message = "aggregation_interval must be one of 1, 5, or 10 minutes."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      contains(["vpc", "subnet", "eni"], flow_log.resource_type)
    ])
    error_message = "resource_type must be one of vpc, subnet, or eni."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      contains(["All", "Allow", "Drop"], flow_log.traffic_type)
    ])
    error_message = "traffic_type must be one of All, Allow, or Drop."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      contains(["Active", "Inactive"], flow_log.status)
    ])
    error_message = "status must be Active or Inactive when specified."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      length(trimspace(flow_log.flow_log_name)) >= 1 &&
      length(flow_log.flow_log_name) <= 128 &&
      trimspace(flow_log.resource_id) != "" &&
      can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", flow_log.log_project_name)) &&
      can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", flow_log.log_topic_name))
    ])
    error_message = "flow_log_name must be 1-128 characters; resource_id must be non-empty; log project and topic names must be 3-63 lowercase alphanumeric or hyphen characters with alphanumeric ends."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      flow_log.description == null ? true : length(flow_log.description) <= 255
    ])
    error_message = "description must contain at most 255 characters."
  }

  validation {
    condition = alltrue([
      for flow_log in values(var.flow_logs) :
      flow_log.tags == null ? true : (
        length(flow_log.tags) <= 50 &&
        alltrue([
          for tag_key, tag_value in flow_log.tags :
          length(trimspace(tag_key)) >= 1 &&
          length(tag_key) <= 128 &&
          length(tag_value) <= 256
        ])
      )
    ])
    error_message = "tags must contain at most 50 entries; tag keys must be 1-128 non-blank characters and tag values at most 256 characters."
  }
}
