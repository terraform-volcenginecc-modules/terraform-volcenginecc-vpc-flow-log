# terraform-volcenginecc-vpc-flow-log

## 1. Overview

Terraform module for managing Volcengine VPC FLOW LOG resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID. The module manages only Flow Logs; the examples additionally create their Log Service project, topic, index, and optional TOS delivery.

## 2. Usage

```hcl
module "vpc_flow_log" {
  source  = "terraform-volcenginecc-modules/vpc-flow-log/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## 3. Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

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
| `volcenginecc_vpc_flow_log` | Module-defined volcenginecc_vpc_flow_log. |

## 7. Inputs

| Name | Description |
|---|---|
| `flow_logs` | Module-defined flow_logs. |

## 8. Outputs

| Name | Description |
|---|---|
| `flow_log_ids` | Module-defined flow_log_ids. |
| `flow_logs` | Flow Log IDs, names, targets, status, traffic type, and stable provider metadata keyed by `flow_logs` keys. |

## 9. Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- `flow_logs` excludes the provider's volatile computed `updated_at` timestamp. Use resource metadata other than update time for downstream automation.
