remote_state {
  backend = "s3"
  config = {
    bucket         = "fraud-detect-terraform-state-${get_env("AWS_REGION", "us-east-1")}-${get_env("ENV", "dev")}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = get_env("AWS_REGION", "us-east-1")
    encrypt        = true
    dynamodb_table = "fraud-detect-terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${get_env("AWS_REGION", "us-east-1")}"
  default_tags {
    tags = {
      Environment = "${get_env("ENV", "dev")}"
      Project     = "fraud-detect"
      ManagedBy   = "terragrunt"
    }
  }
}
EOF
}

# Configure Terragrunt to automatically format terraform code
terraform {
  before_hook "before_hook" {
    commands = ["apply", "plan"]
    execute  = ["terraform", "fmt", "-recursive"]
  }
}

# Default inputs for all modules
inputs = {
  project     = "fraud-detect"
  environment = get_env("ENV", "dev")
  region      = get_env("AWS_REGION", "us-east-1")
}