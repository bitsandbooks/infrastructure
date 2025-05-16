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

resource "digitalocean_volume" "tf_do_volume" {
  name                     = "${var.item_prefix}-${var.do_region}-${var.item_label}"
  region                   = var.do_region
  size                     = var.do_volume_size
  initial_filesystem_type  = "ext4"
  initial_filesystem_label = "${var.item_prefix}-${var.item_label} data"
  description              = "${var.item_prefix}-${var.item_label} volume"
  tags                     = ["${var.item_prefix}", "${var.item_label}"]
}
