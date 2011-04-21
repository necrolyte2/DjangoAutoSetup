#
# Cookbook Name:: django
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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
#include_recipe "apache2"
#include_recipe "apache2::#{node[:django][:web_server]}"
include_recipe "nginx"
include_recipe "python"

# Install Django
package "python-django" do
  action :install
end

package "python-flup" do
  action :install
end

# Create the base level django folder
directory "#{node[:django][:apps_dir]}" do
  owner "root"
  group "root"
  mode 0775
  action :create
end

# Setup the apps
node[:django][:apps].each do |app_name, values|
  template "#{node[:nginx][:dir]}/sites-available/#{app_name}" do
    source "default-site.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :public_port => values[:public_port],
      :local_ip => values[:local_ip],
      :local_port => values[:local_port],
      :app_dir => "#{values[:app_dir]}/"
    })
  end

  if not values[:repo].empty?
    # Get the latest source
    git values[:app_dir] do
      repository values[:repo]
      reference "master"
      action :sync
    end
  end

  nginx_site app_name do
    enable true
  end
end

# Disable the default site
nginx_site "default" do
  enable false
end
