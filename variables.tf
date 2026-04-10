variable "ssm_default_host_management" {
  description = "Object of attributes for configuring SSM Default Host Management"
  type = object({
    explorer_settings = optional(list(string), [])
    role = optional(object({
      create = optional(bool, true)
      name   = optional(string)
    }), {})
    update_ssm_agent = optional(object({
      create              = optional(bool, true)
      association_name    = optional(string, "SystemAssociationForSsmAgentUpdate")
      max_concurrency     = optional(string, "50")
      max_errors          = optional(string, "10%")
      schedule_expression = optional(string, "rate(14 days)")
    }), {})
  })
  default  = {}
  nullable = false
}
