variable "sagemaker_policy_document" {
  description = "IAM policy document for SageMaker execution role"
  type        = string
}

variable "sagemaker_model_name" {
  description = "The name of the SageMaker model"
  type        = string
}

variable "sagemaker_image_uri" {
  description = "The URI of the Docker image for the SageMaker model"
  type        = string
}

variable "sagemaker_endpoint_config_name" {
  description = "SageMaker endpoint configuration name"
  type        = string
}

variable "sagemaker_initial_instance_count" {
  description = "Initial instance count for the SageMaker endpoint"
  type        = number
  default     = 1
}

variable "sagemaker_instance_type" {
  description = "Instance type for the SageMaker endpoint"
  type        = string
}

variable "sagemaker_endpoint_name" {
  description = "The name of the SageMaker endpoint"
  type        = string
}

variable "repository_access_mode" {
  description = "Access mode for the repository (e.g., Platform, VPC)"
  type        = string
}

variable "sagemaker_execution_role_name" {
  description = "The name of the SageMaker execution role"
  type        = string
}

variable "sagemaker_policy_name" {
  description = "The name of the SageMaker policy"
  type        = string
}

variable "sagemaker_environment" {
  description = "Environment variables for the SageMaker model"
  type        = map(string)
  default     = {}
}