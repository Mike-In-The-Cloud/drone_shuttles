provider "aws" {
    region = "us-east-1"
    shared_credentials_files = "$HOME/.aws/credentials"
    profile = "default"
}