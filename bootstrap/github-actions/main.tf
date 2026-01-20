################################
# AWS Provider
################################
provider "aws" {
  region = "ap-south-1"
}

################################
# GitHub OIDC Provider
################################
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

################################
# GitHub Actions IAM Role
################################
resource "aws_iam_role" "github_actions" {
  name = "github-actions-terraform-role-1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
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
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_admin" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

################################
# 🔐 EKS ACCESS – GitHub Actions
################################
resource "aws_eks_access_entry" "github_actions" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_iam_role.github_actions.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_actions_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_iam_role.github_actions.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

################################
# 🔐 EKS ACCESS – YOUR LOCAL USER
################################
resource "aws_eks_access_entry" "ashu" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::358871393576:user/Kalyani-Bambal"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "ashu_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::358871393576:user/Kalyani-Bambal"
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
