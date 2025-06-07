provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}

resource "aws_instance" "demo" {
  ami           = "ami-0df99b3a8349462c1" # Amazon Linux 2（東京リージョン）
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-ec2-demo"
  }
}
