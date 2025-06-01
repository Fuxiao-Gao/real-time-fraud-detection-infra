variable "database_name" {
  type        = string
  description = "Name of the Glue database"
}

variable "table_name" {
  type        = string
  description = "Name of the Glue table"
}

variable "storage_descriptor" {
  type        = any
  description = "Configuration block for information about the physical storage of this table."
  default     = null
}