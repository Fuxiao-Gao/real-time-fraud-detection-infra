variable "dashboard_name" {
  description = "The name of the CloudWatch dashboard."
  type        = string
}

variable "dashboard_body" {
  description = "The body of the CloudWatch dashboard in JSON format."
  type        = string
}