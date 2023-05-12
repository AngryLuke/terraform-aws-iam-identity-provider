# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  type        = string
  description = "AWS region name to auth"
}

variable "tfc_org_name" {
  type        = string
  description = "The Terraform Cloud organization name"
}

variable "tfc_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
}

variable "oidc_arn_variable" {
  type        = string
  default     = "openid_arn"
  description = "The arn resource name for oidc Identity Provider created"
}