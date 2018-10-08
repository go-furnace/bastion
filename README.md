# bastion

This furnace project provides code to create a configurable Bastion which gets user data from AWS IAM.

# Prereq

After everything is installed a new user must be configured to use the AWS
services. This should preferrably be a user who has no other access.

Also, the default region must be exported like `AWS_REGION=eu-central-1`.

This Bastion should not be accessible from the outside.

# Usage

Edit the `sshd_config` file to look like this:

```
AuthorizedKeysCommand /etc/ssh/authorized_keys.rb %u %t %k
AuthorizedKeysCommandUser root
```

The script must have root permissions like `0555`.

The script compares the offered keys public key with the public key gathered for the user.

If either the username or the offered key type or the public key that is
derived from the private key the user is using does not match with the record in AWS
IAM user record, then SSH is refused.

