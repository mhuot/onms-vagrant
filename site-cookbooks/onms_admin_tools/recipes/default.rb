include_recipe "apt::default"
node['onms_admin_tools']['packages'].each do |pkg|
  package pkg do
    action [:install]
  end
end
