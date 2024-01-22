module "ssm_default_host_management" {
  source = "../../"

  ssm_default_host_management = {
    update_ssm_agent = {
      create = false
    }
  }
}
