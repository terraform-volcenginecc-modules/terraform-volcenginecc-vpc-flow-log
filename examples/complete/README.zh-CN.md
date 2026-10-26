# COMPLETE VPC FLOW LOG 示例

## 1. 概述

VPC FLOW LOG 模块的可运行 complete 配置。它从输入变量设置 Provider，并调用已发布的 Registry 模块。

## 2. 用法

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. 示例

本目录即为 complete 示例。

## 4. 版本要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Provider

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. 资源

| 名称 | 说明 |
|---|---|
| `volcenginecc_tls_project.flow_log` | 接收 Flow Log 记录的日志服务项目。 |
| `volcenginecc_tls_topic.flow_log` | 配置了保留期的日志服务主题。 |
| `volcenginecc_tls_index.flow_log` | 为日志主题启用的全文索引和自动字段索引。 |
| `volcenginecc_tls_shipper.tos` | 从日志服务主题向调用方自有 TOS bucket 投递的已启用 Shipper。 |
| `terraform-volcenginecc-modules/vpc-flow-log/volcenginecc` | 已发布的 VPC FLOW LOG 模块。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `region` | 模块定义的 region。 |
| `subnet_id` | 模块定义的 subnet_id。 |
| `eni_id` | 模块定义的 eni_id。 |
| `log_project_name` | 模块定义的 log_project_name。 |
| `log_topic_name` | 模块定义的 log_topic_name。 |
| `iam_project_name` | 模块定义的 iam_project_name。 |
| `log_retention_days` | 模块定义的 log_retention_days。 |
| `tos_bucket_name` | 模块定义的 tos_bucket_name。 |
| `shipper_name` | 模块定义的 shipper_name。 |
| `project_name` | 模块定义的 project_name。 |
| `subnet_flow_log_name` | 模块定义的 subnet_flow_log_name。 |
| `eni_flow_log_name` | 模块定义的 eni_flow_log_name。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `flow_log_ids` | 模块定义的 flow_log_ids。 |
| `flow_logs` | 模块定义的 flow_logs。 |
| `log_project` | 模块定义的 log_project。 |
| `log_topic` | 模块定义的 log_topic。 |
| `log_index` | 日志主题的全文索引和自动字段索引配置。 |
| `tos_delivery` | 模块定义的 tos_delivery。 |

## 9. 注意事项

- 请通过 Provider 支持的配置提供凭据，绝不应写入源文件。
- 示例会创建全文索引并启用自动字段索引，无需额外输入参数。
