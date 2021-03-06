# -----------------------------------------------------------------------------
# Lock to a specific Terraform release (for now)
# -----------------------------------------------------------------------------

terraform {
  required_version = "0.11.7"
}

# -----------------------------------------------------------------------------
# Configure our AWS Connection
# -----------------------------------------------------------------------------

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
  version = "1.25.0"
}

# -----------------------------------------------------------------------------
# Other providers
# -----------------------------------------------------------------------------

provider "local" {
  version = "1.1.0"
}

provider "template" {
  version = "1.0.0"
}
