
terraform {
  source = "git::ssh://git@github.com/escanoru/terraform-aws-modules//modules/networking/vpc-example?ref=dev/add-vpc-route-sg-acl"
}

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
}
