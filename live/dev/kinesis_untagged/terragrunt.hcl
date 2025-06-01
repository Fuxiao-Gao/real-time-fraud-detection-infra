include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../modules/kinesis-stream"
}

inputs = {
  name             = local.env_vars.locals.kinesis_untagged
  shard_count      = local.env_vars.locals.kinesis_untagged_shard_count
  retention_period = 24
}