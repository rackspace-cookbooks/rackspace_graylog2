#
# Cookbook Name:: graylog2
# Recipe:: web-interface-only
#
# Copyright (C) 2014, Oudmaijer IT
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'ark'

graylog2_web_service_name = 'graylog2-web-interface'
graylog2_web_package = "https://github.com/Graylog2/graylog2-web-interface/releases/download/#{node['rackspace_graylog2']['web_version']}/graylog2-web-interface-#{node['rackspace_graylog2']['web_version']}.tgz"

group node['rackspace_graylog2']['web_group'] do
  action :create
end

user node['rackspace_graylog2']['web_user'] do
  group node['rackspace_graylog2']['web_group']
  supports manage_home: true
  comment "#{graylog2_web_service_name} user"
  action :create
end

ark graylog2_web_service_name do
  url graylog2_web_package
  home_dir node['rackspace_graylog2']['web_home']
  version node['rackspace_graylog2']['web_version']
  owner node['rackspace_graylog2']['web_user']
  group node['rackspace_graylog2']['web_group']
  notifies :start, "service[#{graylog2_web_service_name}]", :delayed
end

template File.join(node['rackspace_graylog2']['web_home'], "conf/#{graylog2_web_service_name}.conf") do
  source 'graylog2-web-interface.conf.erb'
  owner node['rackspace_graylog2']['web_user']
  group node['rackspace_graylog2']['web_group']
  mode 00644
  notifies :restart, "service[#{graylog2_web_service_name}]", :delayed
end

template File.join(node['rackspace_graylog2']['web_home'], 'conf/application.conf') do
  source 'graylog2-web.application.conf.erb'
  owner node['rackspace_graylog2']['web_user']
  group node['rackspace_graylog2']['web_group']
  mode 00644
  notifies :restart, "service[#{graylog2_web_service_name}]", :delayed
end

template "/etc/init.d/#{graylog2_web_service_name}" do
  source 'graylog2-web-interface.init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, "service[#{graylog2_web_service_name}]", :delayed
end

service graylog2_web_service_name do
  supports restart: true, status: false, reload: false
  action :enable
end
