#
# Cookbook Name:: snort
# Recipe:: default
#

if node['snort']['install'] != true
  return
end

package node['snort']['packages']

template '/etc/snort/snort.conf' do
  source   'snort.conf.erb'
  owner    'root'
  group    'snort'
  mode     0640
  backup   5
  action   :create
  notifies :restart, 'service[snort]', :delayed
end

template '/etc/snort/snort.debian.conf' do
  source   'snort.debian.conf.erb'
  owner    'root'
  group    'root'
  mode     0600
  backup   5
  action   :create
  notifies :restart, 'service[snort]', :delayed
end

service 'snort' do
  action [:enable, :start]
end
