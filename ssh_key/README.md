# Terraform SSH Key Module

This Terraform module is used to create and manage SSH keys for EC2 instances on AWS.
The module generates RSA keys with a specified length and saves the private key to a given path.
It also creates an SSH key object in AWS, which can be used for connecting to instances.

## Description

The module performs the following tasks:

- Generates an RSA private key with a length of 4096 bits.
- Creates an AWS SSH key pair.
- Saves the private key locally in the specified directory.

## Input Variables

- `region` (default "eu-central-1"): The AWS region where the SSH key will be created.
- `key_file_path` (required): The path on your local machine where the private key will be saved.

## Output

- `ssh_key_name`: The name of the SSH key created in AWS.

## Example Usage

### Example Configuration

```hcl
module "ssh_key" {
  source        = "./modules/ssh_key"
  region        = "us-west-2"
  key_file_path = "/path/to/save/key"
}

