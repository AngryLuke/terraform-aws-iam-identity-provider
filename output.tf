output "iam-identity-provider-arn" {
  value = aws_iam_openid_connect_provider.tfc_provider.arn
}

output "iam-identity-provider-url" {
  value = aws_iam_openid_connect_provider.tfc_provider.url
}