#
# Cookbook Name:: demo-tomcat
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override['java']['jdk_version'] = "8"

# Java Community cookbook
include_recipe 'java'

user 'chefdemo'

# Add chefdemo usetr to tomcat group
group 'tomcat' do
  members 'chefdemo'
  action :create
end

# Install latest tomcat to default location using tomcat_install
tomcat_install 'sampleapp' do
  version '8.5.20'
  dir_mode '0755'
  tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz'
  tomcat_user 'tomcat'
  tomcat_group 'tomcat'
end

# custom server.xml listening on 9000
cookbook_file '/opt/tomcat_sampleapp/conf/server.xml' do
  source 'sampleapp_server.xml'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'tomcat_service[sampleapp]'
end

# Download sample.war
remote_file '/opt/tomcat_sampleapp/webapps/sample.war' do
  owner 'tomcat'
  mode '0644'
  source 'https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war'
  checksum '89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5'
end

# start tomcat_sampleapp
tomcat_service 'sampleapp' do
  action [:start, :enable]
  sensitive true
  tomcat_user 'tomcat'
  tomcat_group 'tomcat'
end
