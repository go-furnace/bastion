#!/usr/bin/env ruby

require 'aws-sdk-iam'

client = Aws::IAM::Client.new
resp = client.list_ssh_public_keys(user_name: ARGV[0], max_items: 1)
if resp.ssh_public_keys.size > 0
  # If the user doesn't exist on the machine but has IAM creds in a given
  # account, then it's safe to say that we can grant access to this user
  # and create a local representative.
  system("adduser --disabled-password --gecos \"\" #{ARGV[0]} > /dev/null 2>&1")
end
pub_key_id = resp.ssh_public_keys.first.ssh_public_key_id

puts client.get_ssh_public_key({
  user_name: ARGV[0],
  ssh_public_key_id: pub_key_id,
  encoding: "SSH"
}).ssh_public_key.ssh_public_key_body