include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecr.git?ref=v2.4.0"
}

inputs = {
    repository_name = local.env_vars.locals.ecs_processor_repository
    repository_image_tag_mutability = "MUTABLE"
    force_delete = true

    repository_lifecycle_policy = jsonencode({
      rules = [
        {
          rulePriority = 1,
          description  = "Keep last 5 images",
          selection = {
            tagStatus     = "tagged",
            tagPrefixList = ["v"],
            countType     = "imageCountMoreThan",
            countNumber   = 5
          },
          action = {
            type = "expire"
          }
        }
      ]
  })
}