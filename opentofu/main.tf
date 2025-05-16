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

resource "digitalocean_droplet" "tf_do_droplet" {
  name              = "${var.item_prefix}-${var.item_label}-${var.do_region}"
  image             = var.do_image
  size              = var.do_instance_type
  region            = var.do_region
  ssh_keys          = [var.do_ssh_keyid]
  backups           = true
  droplet_agent     = true
  graceful_shutdown = true
  ipv6              = true
  monitoring        = true
  vpc_uuid          = digitalocean_vpc.tf_do_vpc.id
  depends_on = [
    digitalocean_vpc.tf_do_vpc,
    digitalocean_volume.tf_do_volume
  ]
}

resource "digitalocean_volume_attachment" "do_volume_attach" {
  droplet_id = digitalocean_droplet.tf_do_droplet.id
  volume_id  = digitalocean_volume.tf_do_volume.id
}
