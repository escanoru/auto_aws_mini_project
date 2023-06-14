
terraform {
  source = "git::ssh://git@github.com/escanoru/terraform-aws-modules//modules/services/hello-world-app?ref=dev/add-vpc-route-sg-acl"
}

include "root" {
  path = find_in_parent_folders()
}

include "provider" {
  path = find_in_parent_folders("region_common.hcl")
}

dependency "vpc" {
  config_path = "../vpc"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "non-existing-vpc"
  }
}

inputs = {
  server_text        = "Test for interview"
  environment        = "Demo"
  min_size           = 2
  desired_capacity   = 2
  max_size           = 4
  enable_autoscaling = false
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnet_ids         = dependency.vpc.outputs.subnets_cidr_block[0]
}
