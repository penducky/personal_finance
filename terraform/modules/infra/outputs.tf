output "vpc" {
  value = aws_vpc.main
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_subnet" {
  value = aws_subnet.private
}

output "db_subnet" {
  value = aws_subnet.db
}

output "vpc_endpoint" {
  value = aws_vpc_endpoint.dynamodb
}

