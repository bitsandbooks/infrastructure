terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">=2.53.0"
    }
  }
}

provider "digitalocean" {
  alias = "do"
  token = var.do_token
}
