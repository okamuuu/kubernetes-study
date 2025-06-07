terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "node_app" {
  name = "terraform-node-app"
  build {
    context    = "./app"
  }
}

resource "docker_container" "node_app" {
  name  = "node-app"
  image = docker_image.node_app.name

  ports {
    internal = 3000
    external = 3000
  }
}
