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

variable "do_token" {
  description = "DigitalOcean access token"
  type        = string
  sensitive   = true
}

variable "item_prefix" {
  description = "Namespace prefix for items"
  type        = string
  default     = "my"
}
