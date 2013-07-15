include_recipe "apt::default"

execute "set PGVERSION" do 
  command "export PGVERSION=`pg_lsclusters -h | head -n 1 | cut -d' ' -f1`"
end

ruby_block "Adjust locale" do
  block do    
    ENV['LANGUAGE'] = "en_US.utf-8"
    ENV['LANG'] = "en_US.utf-8"
    ENV['LC_ALL'] = "en_US.utf-8"
  end
end

include_recipe "postgresql::server"

service "postgresql" do
  action :enable
  supports :status => true, :restart => true, :start => true, :stop => true
end

template "#{node[:opennms][:pg_hba_location]}" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode "00740"
  variables ({
    :pg_auth_method => node[:opennms][:pg_auth_method]
    })
  notifies :restart, resources(:service => "postgresql"), :immediately
end

package "openjdk-7-jdk" do
  action :install
end

package "opennms" do
  action :install
end

template "/etc/profile.d/opennms.sh" do
  source "opennms.sh.erb"
  owner "root"
  group "root"
  mode "00755"
  variables ({
    :opennms_home => node[:opennms][:opennms_home]
    })
end

ruby_block "Add OPENNMS_HOME environment variable and $OPENNMS_HOME/bin to the path" do
  block do
    ENV['PATH'] = node[:opennms][:opennms_home] + '/bin:' + ENV['PATH']
    ENV['OPENNMS'] = node[:opennms][:opennms_home]
  end
end

execute "set java for OpenNMS" do
  command "runjava -s"
end

template "#{node[:opennms][:opennms_home]}/etc/opennms.conf" do
  source "opennms.conf.erb"
  owner "root"
  group "root"
  mode "00644"
  variables ({
    :opennms_home => node[:opennms][:opennms_home]
    })
end

execute "install OpenNMS" do
  command "#{node[:opennms][:opennms_home]}/bin/install -dis"
end

service "opennms" do
  supports :status => true, :restart => true, :start => true, :stop => true
  action [:enable, :start]
end