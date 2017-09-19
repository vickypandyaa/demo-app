local_mode true
chef_repo_path  File.expand_path('../' , __FILE__)
current_dir = File.dirname(__FILE__)
cookbook_path ["#{current_dir}/../cookbooks", "#{current_dir}/../berks-cookbooks"]

knife[:ssh_attribute] = "knife_zero.host"
knife[:use_sudo] = true
knife[:identity_file] = "~/.ssh/DemoApp.pem"
knife[:secret_file] = "/tmp/encrypted_data_bag_secret"

# Amazon AWS
knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']

knife[:automatic_attribute_whitelist] = %w[
  fqdn
  os
  os_version
  hostname
  ipaddress
  roles
  recipes
  ipaddress
  platform
  platform_version
  cloud
  cloud_v2
  ec2/ami_id
  ec2/instance_id
  ec2/instance_type
  ec2/placement_availability_zone
  chef_packages
]
