# Create the trust policy for SageMaker
data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Let SageMaker assume the role
resource "aws_iam_role" "sagemaker_execution_role" {
  name               = var.sagemaker_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

# IAM policy for SageMaker to access other resources
resource "aws_iam_policy" "sagemaker_policy" {
  name   = var.sagemaker_policy_name
  policy = var.sagemaker_policy_document
}

resource "random_id" "sagemaker_suffix" {
  byte_length = 4
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "sagemaker_role_policy" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = aws_iam_policy.sagemaker_policy.arn
}

# Create SageMaker Model with the execution role ARN
resource "aws_sagemaker_model" "this" {
  name               = "${var.sagemaker_model_name}-${random_id.sagemaker_suffix.hex}"
  execution_role_arn = aws_iam_role.sagemaker_execution_role.arn

  primary_container {
    image = var.sagemaker_image_uri

    image_config {
      repository_access_mode = var.repository_access_mode
    }

    environment = var.sagemaker_environment
  }
}

# create SageMaker Endpoint Configuration
resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.sagemaker_endpoint_config_name}-${random_id.sagemaker_suffix.hex}"

  production_variants {
    variant_name           = "variant-1"
    model_name             = aws_sagemaker_model.this.name
    initial_instance_count = var.sagemaker_initial_instance_count
    instance_type          = var.sagemaker_instance_type
  }
}

# Create SageMaker Endpoint using the configuration
resource "aws_sagemaker_endpoint" "this" {
  name                  = "${var.sagemaker_endpoint_name}-${random_id.sagemaker_suffix.hex}"
  endpoint_config_name  = aws_sagemaker_endpoint_configuration.this.name
}

