terraform {
  backend "s3" {
    bucket = "terraform-s3-spring-peetclinic"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
