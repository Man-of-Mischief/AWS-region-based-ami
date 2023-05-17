# AWS-region-based-ami
This repository contains Terraform code for creating an AWS EC2 instance in a specific region using region-based AMIs. It also creates a security group and key pair for the EC2 instance.

## Prerequisites

Before you begin, ensure that you have the following:

- An AWS account with appropriate permissions to create EC2 instances.
- Terraform installed on your local machine.

## Getting Started

To get started with provisioning the EC2 instance, follow these steps:

1. Clone this repository to your local machine:

```
git clone https://github.com/Man-of-Mischief/AWS-region-based-ami.git
```
2. Navigate to the cloned directory:

```
cd your-repository
```

3. Open the variables.tf file and update the desired values for the variables, such as the instance type, AMI IDs, and region.

4. Initialize the Terraform project:

```
terraform init
```

5. Review the execution plan to see the resources that will be created:

```
terraform plan
```

6. If the plan looks correct, apply the changes to provision the EC2 instance:

```
terraform apply
```

Confirm the action by typing yes when prompted.

# Cleaning Up

To clean up and destroy the created resources, run the following command:

```
terraform destroy
```

Confirm the action by typing yes when prompted.

Note: This will permanently delete the provisioned EC2 instance and cannot be undone.
