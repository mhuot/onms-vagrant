node['onms-admin-tools']['packages'].each do |pkg|
  package pkg do
    action [:install]
  end
end
