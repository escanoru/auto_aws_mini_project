
terraform {
  source = "git::ssh://git@github.com/escanoru/terraform-aws-modules//modules/networking/vpc-example?ref=dev/new-modules-for-demo"
}

# Indicate what region to deploy the resources into

include "root" {
  path = find_in_parent_folders()
}

include "provider" {
  path = find_in_parent_folders("region_common.hcl")
}

inputs = {
  vpc_name               = "terratest-example-vpc"
  cidr_block             = "10.101.0.0/16"
  number_private_subnets = 2

  enable_dns_hostnames = false
  enable_dns_support   = true
}
