node.default['clamav']['install'] = true
node.default['clamav']['packages'] = %w(
  clamav
  clamav-daemon
)
