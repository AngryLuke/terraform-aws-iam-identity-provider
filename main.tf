# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region
}

# Data source used to grab the TLS certificate for Terraform Cloud.
#
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate
data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfc_hostname}"
}

# Creates an OIDC provider which is restricted to
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = data.tls_certificate.tfc_certificate.url
  client_id_list  = [var.tfc_aws_audience]
  thumbprint_list = [data.tls_certificate.tfc_certificate.certificates[0].sha1_fingerprint]
}

# Creates a variable set with OIDC ARN resource
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set
resource "tfe_variable_set" "oidc_arn" {
  name         = "aws-oidc-arn"
  description  = "Variable set applied to all workspaces."
  global       = true
  organization = var.tfc_org_name
}

resource "tfe_variable" "oidc_arn_content" {
  key             = var.oidc_arn_variable
  value           = aws_iam_openid_connect_provider.tfc_provider.arn
  category        = "terraform"
  description     = "The arn resource name for oidc Identity Provider created"
  variable_set_id = tfe_variable_set.oidc_arn.id
}