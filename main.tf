resource "aws_ssm_service_setting" "this" {
  for_each = toset(concat(
    length(var.ssm_default_host_management.explorer_settings) > 0 ? var.ssm_default_host_management.explorer_settings : keys(local.ssm_explorer_service_settings),
    keys(local.ssm_default_host_management_service_settings)
  ))

  setting_id    = "arn:${local.partition}:ssm:${local.region}:${local.account_id}:servicesetting${each.key}"
  setting_value = local.ssm_service_settings[each.key]

  lifecycle {
    precondition {
      condition     = can(local.ssm_service_settings[each.key])
      error_message = "The setting \"${each.key}\" is not recognized as a valid SSM service setting for Default Host Management."
    }
  }
}

resource "aws_ssm_association" "update_ssm_agent" {
  count = var.ssm_default_host_management.update_ssm_agent.create ? 1 : 0

  name                = "AWS-UpdateSSMAgent"
  association_name    = var.ssm_default_host_management.update_ssm_agent.association_name
  schedule_expression = var.ssm_default_host_management.update_ssm_agent.schedule_expression

  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
}

resource "aws_iam_role" "default_host_management" {
  count = var.ssm_default_host_management.role.create ? 1 : 0

  name = "AWSSystemsManagerDefaultEC2InstanceManagementRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ssm.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "default_host_management" {
  count = var.ssm_default_host_management.role.create ? 1 : 0

  role       = aws_iam_role.default_host_management[0].name
  policy_arn = "arn:${local.partition}:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}

resource "aws_iam_role_policy_attachments_exclusive" "example" {
  count = var.ssm_default_host_management.role.create ? 1 : 0

  role_name   = aws_iam_role.default_host_management[0].name
  policy_arns = [aws_iam_role_policy_attachment.default_host_management[0].policy_arn]
}

locals {
  account_id = data.aws_caller_identity.this.account_id
  partition  = data.aws_partition.this.partition
  region     = data.aws_region.this.region

  # If the default host management role name is not specified, use aws_iam_role.
  # Otherwise, use the role name provided by the user.
  default_host_management_role = var.ssm_default_host_management.role.create ? (
    trimprefix("${aws_iam_role.default_host_management[0].path}${aws_iam_role_policy_attachment.default_host_management[0].role}", "/")
    ) : (
    var.ssm_default_host_management.role.name
  )

  # Map of valid SSM service settings related to enabling SSM Explorer, and the
  # "value" needed to enable it. SSM Explorer is part of the Quick Start for SSM
  # Default Host Management.
  ssm_explorer_service_settings = {
    "/ssm/opsitem/ssm-patchmanager" : "Enabled"
    "/ssm/opsitem/EC2" : "Enabled"
    "/ssm/opsdata/ConfigCompliance" : "Enabled"
    "/ssm/opsdata/Association" : "Enabled"
    "/ssm/opsdata/OpsData-TrustedAdvisor" : "Enabled"
    "/ssm/opsdata/ComputeOptimizer" : "Enabled"
    "/ssm/opsdata/SupportCenterCase" : "Enabled"
    "/ssm/opsdata/ExplorerOnboarded" : "true"
  }

  ssm_default_host_management_service_settings = {
    "/ssm/managed-instance/default-ec2-instance-management-role" : local.default_host_management_role
  }

  ssm_service_settings = merge(local.ssm_explorer_service_settings, local.ssm_default_host_management_service_settings)
}


data "aws_caller_identity" "this" {}
data "aws_partition" "this" {}
data "aws_region" "this" {}
