#
# Cookbook Name:: fail2ban
# Recipe:: default
#

package node['fail2ban']['packages']

%w[
  /var/log/fail2ban
  /etc/systemd/system/fail2ban.service.d
].each do |d|
  directory d
end

template '/etc/systemd/system/fail2ban.service.d/override.conf' do
  source 'override.conf.erb'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template '/etc/fail2ban/fail2ban.local' do
  source 'fail2ban.local.erb'
  notifies :restart, 'service[fail2ban]', :delayed
end

template '/etc/fail2ban/jail.local' do
  source 'jail.local.erb'
  notifies :restart, 'service[fail2ban]', :delayed
end

service 'fail2ban' do
  action [:enable, :start]
end
