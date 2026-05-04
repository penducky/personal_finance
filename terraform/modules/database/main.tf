resource "aws_dynamodb_table" "orders" {
  name         = "${var.project}-${var.env}-orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "order_id"

  attribute {
    name = "order_id"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = {
    Name = "${var.project}-${var.env}-orders"
  }
}


resource "aws_dynamodb_table" "inventory" {
  name         = "${var.project}-${var.env}-inventory"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = {
    Name = "${var.project}-${var.env}-inventory"
  }
}