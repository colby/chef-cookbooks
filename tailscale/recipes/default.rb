#
# Cookbook Name:: tailscale
# Recipe:: default
#

apt_repository 'tailscale' do
  uri 'https://pkgs.tailscale.com/stable/ubuntu'
  components ['main']
  keyserver 'https://pkgs.tailscale.com/stable/ubuntu/bionic.gpg'
end

package node['tailscale']['packages']

gpg_key = Chef::Config[:file_cache_path] + '/bionic.gpg'

file gpg_key do
  action :delete
end

service 'tailscaled' do
  action [:enable, :start]
end
