variable "region" {
  description = "Volcengine region containing the existing resources."
  type        = string
  default     = "cn-beijing"
}

variable "vpc_id" {
  description = "ID of the existing VPC whose complete traffic will be collected."
  type        = string
}

variable "log_project_name" {
  description = "Name of the existing Log Service project receiving the flow log."
  type        = string
}

variable "log_topic_name" {
  description = "Name of the Log Service topic created for the flow log."
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

variable "flow_log_name" {
  description = "Name of the flow log to create."
  type        = string
  default     = "vpc-all-traffic"
}
