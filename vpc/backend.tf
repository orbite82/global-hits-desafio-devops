terraform {
  backend "s3" {
    bucket         = "devosp-desafio-bucket-terraform" # Altere para o seu bucket caso necessário
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1" # Altere para sua região caso necessário
  }
}