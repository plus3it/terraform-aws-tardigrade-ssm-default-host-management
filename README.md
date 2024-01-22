# terraform-aws-tardigrade-ssm-default-host-management

Terraform module for managing SSM Default Host Management. This module also has
options to enable AWS SSM Explorer, and configure an SSM Association to auto-update
the SSM Agent on all EC2 instances. In total, the module instends to implement
the same features as the [Quick Setup for Default Host Management in an AWS Organization](https://docs.aws.amazon.com/systems-manager/latest/userguide/quick-setup-default-host-management-configuration.html).

Generic repo template for Plus3IT repositories

To use this template:

1. Select the green "Use this template" button, or [click here](https://github.com/plus3it/repo-template/generate).
2. Select the repo Owner, give the repo a name, enter a description, select Public or Private, and click "Create repository from template".
3. Clone the repository and create a new branch.
4. Edit the following files to customize them for the new repository:
    * `LICENSE`
        * Near the end of the file, edit the date and change the repository name
    * `CHANGELOG.template.md`
        * Rename to `CHANGELOG.md`, replacing the repo-template changelog
        * Edit templated items for the new repo
    * `.bumpversion.cfg`
        * Edit the version number for the new repo, ask team if not sure what to
          start with
    * `README.md`
        * Replace contents for the new repo
    * `.github/`
        * Inspect dependabot and workflow files in case changes are needed for
          the new repo
5. Commit the changes and open a pull request
