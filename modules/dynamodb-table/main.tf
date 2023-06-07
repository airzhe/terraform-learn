module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "terraform-lock"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
