output "do_droplet_ipv4_address_public" {
  description = "IPv4 address, external"
  value       = digitalocean_droplet.tf_do_droplet.ipv4_address
}

output "do_droplet_ipv4_address_private" {
  description = "IPv4 address, internal"
  value       = digitalocean_droplet.tf_do_droplet.ipv4_address_private
}

output "do_volume_id" {
  description = "The UUID of the created volume"
  value       = digitalocean_volume.tf_do_volume.id
  sensitive   = false
}

output "do_vpc_id" {
  description = "The UUID of the created VPC"
  value       = digitalocean_vpc.tf_do_vpc.id
}
