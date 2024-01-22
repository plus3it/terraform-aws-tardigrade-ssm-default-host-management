module "ssm_default_host_management" {
  source = "../../"

  ssm_default_host_management = {
    role = {
      create = false
      name   = aws_iam_role.default_host_management.name
    }
  }
}

resource "aws_iam_role" "default_host_management" {
  name = "CustomDefaultEC2InstanceManagementRole"

  managed_policy_arns = ["arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"]

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

data "aws_partition" "this" {}
