module "ssm_default_host_management" {
  source = "../../"

  ssm_default_host_management = {
    role = {
      create = false
      name   = aws_iam_role_policy_attachment.default_host_management.role
    }
  }
}

resource "aws_iam_role" "default_host_management" {
  name = "CustomDefaultEC2InstanceManagementRole"

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
  role       = aws_iam_role.default_host_management.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}

data "aws_partition" "this" {}
