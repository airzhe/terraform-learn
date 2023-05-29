terraform {
  cloud {
    organization = "runner-aws"

    workspaces {
      name = "learn"
    }
  }
}