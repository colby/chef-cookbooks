#
# Cookbook Name:: clamav
# Recipe:: default
#

if node['clamav']['install'] != true
  return
end

execute 'update apt if needed' do
  command 'apt-get update'
  only_if do
    !File.exists?('/var/lib/apt/periodic/update-success-stamp') ||
      File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

package node['clamav']['packages']

execute 'initial update for clamav database files' do
  user    'root'
  command 'systemctl stop clamav-freshclam && freshclam'
  creates '/var/lib/clamav/daily.cvd'
end

template '/etc/clamav/clamd.conf' do
  source   'clamd.conf.erb'
  owner    'root'
  group    'root'
  mode     0644
  action   :create
  notifies :restart, 'service[clamav-daemon]', :immediately
end

template '/etc/clamav/freshclam.conf' do
  source 'freshclam.conf.erb'
  owner  'clamav'
  group  'adm'
  mode   0444
  action :create
end

service 'clamav-daemon' do
  action [:enable, :start]
end

service 'clamav-freshclam' do
  action [:enable, :start]
end
