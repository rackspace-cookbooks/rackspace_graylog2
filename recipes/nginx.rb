#
# Cookbook Name:: graylog2
# Recipe:: nginx
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
include_recipe "nginx::default"

template "#{node.nginx.dir}/sites-available/graylog2-web-interface.conf" do
  source "nginx.conf.erb"
  mode "0644"
  notifies :restart, "service[nginx]", :delayed
end

nginx_site "graylog2-web-interface.conf"