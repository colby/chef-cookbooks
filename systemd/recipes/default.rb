#
# Cookbook Name:: systemd
# Recipe:: default
#

execute 'daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

include_recipe 'systemd::journald'
