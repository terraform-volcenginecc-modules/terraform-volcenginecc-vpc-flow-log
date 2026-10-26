# COMPLETE VPC FLOW LOG Example

## 1. Overview

Runnable complete configuration for the VPC FLOW LOG module. It configures the provider from input variables and calls the published Registry module.

## 2. Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. Examples

This directory is the complete example.

## 4. Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. Resources

| Name | Description |
|---|---|
| `volcenginecc_tls_project.flow_log` | Log Service project that receives Flow Log records. |
| `volcenginecc_tls_topic.flow_log` | Log Service topic with the configured retention period. |
| `volcenginecc_tls_index.flow_log` | Full-text index with automatic field indexing enabled for the topic. |
| `volcenginecc_tls_shipper.tos` | Enabled delivery from the Log Service topic to the caller-owned TOS bucket. |
| `terraform-volcenginecc-modules/vpc-flow-log/volcenginecc` | Published VPC FLOW LOG module. |

## 7. Inputs

| Name | Description |
|---|---|
| `region` | Module-defined region. |
| `subnet_id` | Module-defined subnet_id. |
| `eni_id` | Module-defined eni_id. |
| `log_project_name` | Module-defined log_project_name. |
| `log_topic_name` | Module-defined log_topic_name. |
| `iam_project_name` | Module-defined iam_project_name. |
| `log_retention_days` | Module-defined log_retention_days. |
| `tos_bucket_name` | Module-defined tos_bucket_name. |
| `shipper_name` | Module-defined shipper_name. |
| `project_name` | Module-defined project_name. |
| `subnet_flow_log_name` | Module-defined subnet_flow_log_name. |
| `eni_flow_log_name` | Module-defined eni_flow_log_name. |

## 8. Outputs

| Name | Description |
|---|---|
| `flow_log_ids` | Module-defined flow_log_ids. |
| `flow_logs` | Module-defined flow_logs. |
| `log_project` | Module-defined log_project. |
| `log_topic` | Module-defined log_topic. |
| `log_index` | Full-text and automatic-field index configuration for the log topic. |
| `tos_delivery` | Module-defined tos_delivery. |

## 9. Notes

- Supply credentials through supported provider configuration, never in source files.
- The example creates a full-text index and enables automatic field indexing. No additional input is required.
