#
# Cookbook Name:: systemd
# Recipe:: journald
#

template '/etc/systemd/journald.conf' do
  source 'journald.conf.erb'
  notifies :restart, 'service[systemd-journald]', :delayed
end

service 'systemd-journald' do
  action :start
end
