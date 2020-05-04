node.default['prometheus']['install'] = true
node.default['prometheus']['packages'] = %w(
  prometheus-node-exporter
)
