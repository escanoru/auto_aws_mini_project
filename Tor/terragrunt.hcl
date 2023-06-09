
locals {
  deployment_commons = read_terragrunt_config((find_in_parent_folders("deployment_commons.hcl")))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = local.deployment_commons.locals.terraform_state_s3_bucket

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.deployment_commons.locals.terraform_state_aws_region
    encrypt        = true
    dynamodb_table = local.deployment_commons.locals.dynamodb_table
  }
}

inputs = { 
  allowed_account_ids = local.deployment_commons.locals.aws_account_id
}


// This load but it doesn't read the actual value we're looking for (aws_region)
// inputs = merge(
//   {
//     inputs = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
//   },
//   {
//     allowed_account_ids = "386734656804"
//   }
// )