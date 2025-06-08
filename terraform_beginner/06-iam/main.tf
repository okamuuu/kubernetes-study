provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_user" "terraform_user" {
  name = "terraform-user"
}

resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "terraform-user-policy"
  user = aws_iam_user.terraform_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "s3:*",
          "iam:ListUsers"
          # Terraformで操作したいAWSサービスの権限をここに追加してください
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "terraform_user_key" {
  user = aws_iam_user.terraform_user.name
}

output "access_key_id" {
  value = aws_iam_access_key.terraform_user_key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.terraform_user_key.secret
  sensitive = true
}