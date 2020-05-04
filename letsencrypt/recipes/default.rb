#
# Cookbook Name:: letsencrypt
# Recipe:: default
#

package node['letsencrypt']['packages']

directory '/etc/systemd/system/certbot.service.d/'

template '/etc/systemd/system/certbot.service.d/override.conf' do
  source 'override.conf.erb'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template '/etc/nginx/conf.d/letsencrypt' do
  source 'letsencrypt.nginx.erb'
  notifies :reload, 'service[nginx]', :delayed
end

execute 'systemctl daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

execute 'init certificate' do
  command 'service nginx stop;
    certbot certonly
      --standalone
      --preferred-challenges http
      --cert-name colbyolson.com
      -d colbyolson.com,www.colbyolson.com
      -m letsencrypt@colbyolson.com
      --agree-tos;
    service nginx start'
  action :run
  not_if 'certbot certificates | grep colbyolson.com'
end
