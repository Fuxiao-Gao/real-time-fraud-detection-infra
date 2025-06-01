include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  dashboard_body = templatefile("${get_terragrunt_dir()}/dashboardBody.json.tpl", 
  {
    namespace = local.env_vars.locals.prefix
  })
}

terraform {
  source = "../../../modules/cloudwatch_dashboard"
}

inputs = {
  dashboard_name = "${local.env_vars.locals.prefix}-cloudwatch-dashboard"
  dashboard_body = local.dashboard_body
}