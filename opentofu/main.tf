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

resource "digitalocean_vpc" "tf_do_vpc" {
  name        = "${var.item_prefix}-${var.do_region}-vpc"
  region      = var.do_region
  description = "${var.item_prefix} VPC in ${var.do_region}"
}
