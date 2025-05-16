output "do_volume_id" {
  description = "The UUID of the created volume"
  value       = digitalocean_volume.tf_do_volume.id
  sensitive   = false
}
output "do_vpc_id" {
  description = "The UUID of the created VPC"
  value       = digitalocean_vpc.tf_do_vpc.id
}
