variable "do_image" {
  type        = string
  description = <<EOT
        DigitalOcean Images available. Send to list all available Images: curl -X GET \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/images?page=1&per_page=100&type=distribution" | jq '.images[].slug'
        EOT
  default     = "debian-12-x64"
}

variable "do_instance_type" {
  type        = string
  description = <<EOT
        DigitalOcean Droplets types to use. Send to list all available Droplets types: curl -X GET \
        -H "Content-Type: application/json"
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/sizes" | jq '.sizes[].slug'
        EOT
  default     = "s-1vcpu-2gb"
}

variable "do_region" {
  type        = string
  description = <<EOT
        DigitalOcean available regions. Send to list all available Regions: curl -X GET \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <your-digital-ocean-token>" \
        "https://api.digitalocean.com/v2/regions" | jq '.regions[].slug'
        EOT
  default     = "nyc1"
}

variable "do_ssh_keyid" {
  description = "Root user SSH key"
  type        = string
  sensitive   = true
}

variable "do_token" {
  description = "DigitalOcean access token"
  type        = string
  sensitive   = true
}

variable "do_volume_size" {
  description = "Volume size in gigabytes"
  type        = number
  default     = 5
}

variable "item_label" {
  type        = string
  description = "The name to apply to this DigitalOcean instance"
  default     = "charlie"
}

variable "item_prefix" {
  description = "Namespace prefix for items"
  type        = string
  default     = "my"
}
