terraform {
  backend "s3" {
    bucket         = "my-unique-bucket-name-2224"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}