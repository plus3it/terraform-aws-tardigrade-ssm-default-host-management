# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module configures SSM Default Host Management. It sets the SSM service setting for the default EC2 instance management role, creating the `AWSSystemsManagerDefaultEC2InstanceManagementRole` IAM role by default, and it also enables the SSM Explorer service settings and creates an `AWS-UpdateSSMAgent` association that updates the SSM Agent. Everything is set through the single `ssm_default_host_management` object input (`role`, `explorer_settings`, and `update_ssm_agent`), and the module has no outputs.
