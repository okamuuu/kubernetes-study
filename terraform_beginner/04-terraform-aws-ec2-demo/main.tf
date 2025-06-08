provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}

resource "aws_instance" "demo" {
  ami           = "ami-0da9a208c352ca999" # 2025年06月
  instance_type = "t2.micro"
  key_name      = "okamuuu-dev"

  // この辺りの処理は Terraform でやるべきかどうか、まだわかっていない
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
              sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
            EOF
            
  tags = {
    Name = "terraform-ec2-demo"
  }
}
