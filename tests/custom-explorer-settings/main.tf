module "ssm_default_host_management" {
  source = "../../"

  ssm_default_host_management = {
    explorer_settings = [
      "/ssm/opsitem/EC2",
      "/ssm/opsdata/ExplorerOnboarded",
    ]
  }
}
