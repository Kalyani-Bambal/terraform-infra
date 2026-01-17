provider "aws" {
  region = "ap-south-1"
}

data "aws_caller_identity" "current" {}
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name = "github-actions-terraform-role-1"

  assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [{
    Effect = "Allow"
    Principal = {
      Federated = data.aws_iam_openid_connect_provider.github.arn
    }
    Action = "sts:AssumeRoleWithWebIdentity"
    Condition = {
      StringLike = {
        "token.actions.githubusercontent.com:sub" = "repo:Kalyani-Bambal/terraform-infra:*"
      }
    }
  }]
})
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
