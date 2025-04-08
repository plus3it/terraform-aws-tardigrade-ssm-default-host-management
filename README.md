# terraform-aws-tardigrade-ssm-default-host-management

Terraform module for managing SSM Default Host Management. This module also has
options to enable AWS SSM Explorer, and configure an SSM Association to auto-update
the SSM Agent on all EC2 instances. In total, the module instends to implement
the same features as the [Quick Setup for Default Host Management in an AWS Organization](https://docs.aws.amazon.com/systems-manager/latest/userguide/quick-setup-default-host-management-configuration.html).

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.72.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssm_default_host_management"></a> [ssm\_default\_host\_management](#input\_ssm\_default\_host\_management) | Object of attributes for configuring SSM Default Host Management | <pre>object({<br/>    explorer_settings = optional(list(string), [])<br/>    role = optional(object({<br/>      create = optional(bool, true)<br/>      name   = optional(string)<br/>    }), {})<br/>    update_ssm_agent = optional(object({<br/>      create              = optional(bool, true)<br/>      association_name    = optional(string, "UpdateSSMAgent-do-not-delete")<br/>      schedule_expression = optional(string, "rate(14 days)")<br/>    }), {})<br/>  })</pre> | `{}` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->
