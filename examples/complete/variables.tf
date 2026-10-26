variable "region" {
  description = "Volcengine region containing the existing resources."
  type        = string
  default     = "cn-beijing"
}

variable "subnet_id" {
  description = "ID of the existing subnet for rejected-traffic collection."
  type        = string
}

variable "eni_id" {
  description = "ID of the existing ENI for all-traffic collection."
  type        = string
}

variable "log_project_name" {
  description = "Name of the existing Log Service project receiving flow logs."
  type        = string
}

variable "log_topic_name" {
  description = "Name of the Log Service topic created for flow logs."
  type        = string
}

variable "iam_project_name" {
  description = "Optional IAM project name associated with the Log Service project."
  type        = string
  default     = null
}

variable "log_retention_days" {
  description = "Log retention period in days for the created Log Service topic."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 1 && var.log_retention_days <= 3650
    error_message = "log_retention_days must be between 1 and 3650."
  }
}

variable "tos_bucket_name" {
  description = "Name of an existing same-region TOS bucket receiving archived logs. The bucket is caller-owned and is not destroyed by this example."
  type        = string
}

variable "shipper_name" {
  description = "Name of the enabled TLS shipper delivering the log topic to TOS."
  type        = string
  default     = "vpc-flow-log-tos"
}

variable "project_name" {
  description = "Optional Volcengine project name for newly created flow logs."
  type        = string
  default     = null
}

variable "subnet_flow_log_name" {
  description = "Name of the subnet rejected-traffic flow log."
  type        = string
  default     = "subnet-rejected-traffic"
}

variable "eni_flow_log_name" {
  description = "Name of the ENI all-traffic flow log."
  type        = string
  default     = "eni-all-traffic"
}
