
terraform {
  // source = "tfr:///terraform-aws-modules/vpc/aws?version=5.1.0"
    source = "git::ssh://git@github.com/escanoru/terraform-aws-modules//modules/networking/vpc-vanilla?ref=dev/new-modules-for-demo"
}

# Indicate what region to deploy the resources into

include "root" {
  path = find_in_parent_folders()
}

include "provider" {
    path = find_in_parent_folders("region_common.hcl")
}

# Indicate the input values to use for the variables of the module.
inputs = {
  name = "terratest-example-vpc"
  cidr_block = "10.0.101.0/16"

  enable_dns_hostnames = false
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
