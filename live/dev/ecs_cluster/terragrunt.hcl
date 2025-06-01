
include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs.git//modules/cluster?ref=v5.12.1"
}

inputs = {
    cluster_name = local.env_vars.locals.ecs_cluster_name

    # Create CloudWatch log group
    cloudwatch_log_group_name = "/ecs/${local.env_vars.locals.prefix}"
    cloudwatch_log_group_retention_in_days = 1
}
