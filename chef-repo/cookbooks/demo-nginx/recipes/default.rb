include_recipe 'nginx'

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")

certs = Chef::EncryptedDataBagItem.load("test", "ssl", secret)

# custom nginx conf forwarding traffic to tomcat on port 9000
cookbook_file '/etc/nginx/sites-available/default' do
  source 'demo_default'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]', :delayed
end

# configure nginx self signed ssl key
file '/etc/ssl/private/nginx-selfsigned.key' do
  content certs['key']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[nginx]', :delayed
end

# configure nginx self signed ssl cert
file '/etc/ssl/certs/nginx-selfsigned.crt' do
  content certs['cert']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[nginx]', :delayed
end
