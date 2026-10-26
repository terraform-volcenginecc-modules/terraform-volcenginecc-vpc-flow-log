# terraform-volcenginecc-vpc-flow-log

## 1. 概述

基于 `volcenginecc` Provider 管理火山引擎 VPC FLOW LOG 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。模块仅管理 Flow Log；示例会额外创建日志服务 Project、Topic、索引，以及可选的 TOS 投递。

## 2. 用法

```hcl
module "vpc_flow_log" {
  source  = "terraform-volcenginecc-modules/vpc-flow-log/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
```

## 3. 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

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
| `volcenginecc_vpc_flow_log` | 模块定义的 volcenginecc_vpc_flow_log。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `flow_logs` | 模块定义的 flow_logs。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `flow_log_ids` | 模块定义的 flow_log_ids。 |
| `flow_logs` | 按 `flow_logs` key 返回的 Flow Log ID、名称、采集目标、状态、流量类型和稳定的 Provider 元数据。 |

## 9. 注意事项

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- `flow_logs` 不输出 Provider 的易变计算字段 `updated_at`。下游自动化应使用更新时间以外的资源元数据。
