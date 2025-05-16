output "do_vpc_id" {
  description = "The UUID of the created VPC"
  value       = digitalocean_vpc.tf_do_vpc.id
}
