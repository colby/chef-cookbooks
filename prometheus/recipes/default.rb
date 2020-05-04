#
# Cookbook Name:: prometheus
# Recipe:: default
#

if node['prometheus']['install'] != true
  return
end

execute 'update apt if needed' do
  command 'apt-get update'
  only_if do
    !File.exists?('/var/lib/apt/periodic/update-success-stamp') ||
      File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

package node['prometheus']['packages']

service 'prometheus-node-exporter' do
  action [:enable, :start]
end
