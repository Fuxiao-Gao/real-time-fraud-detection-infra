include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependencies {
  paths = [
    "../s3_bucket",
  ]
}

dependency "s3_bucket" {
  config_path = "../s3_bucket"
}

terraform {
  source = "../../../modules/glue"
}

inputs = {
  database_name = local.env_vars.locals.glue_database_name
  table_name    = local.env_vars.locals.glue_table_name

  storage_descriptor = {
    location      = "${dependency.s3_bucket.outputs.s3_bucket_arn}/${local.env_vars.locals.s3_posts_prefix}"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    columns = [
      { name = "uri",                    type = "string" },
      { name = "time_utc",               type = "string" },
      { name = "text",                   type = "string" },
      { name = "media_paths",            type = "array<string>" },
      { name = "fraud_text_likelihood",  type = "double" },
      { name = "fraud_media_likelihood", type = "double" }
    ]
  }
}
