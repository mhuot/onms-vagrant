case platform
when "redhat", "centos", "scientific", "fedora", "suse", "amazon", "oracle"
  default['opennms']['opennms_home'] = '/opt/opennms'
  default['opennms']['pg_hba_location'] = '/var/lib/postgresql/9.1/main/pg_hba.conf' # TODO: Need to validate location
when "debian", "ubuntu"
  default['opennms']['opennms_home'] = '/usr/share/opennms'
  default['opennms']['pg_hba_location'] = '/etc/postgresql/9.1/main/pg_hba.conf' #TODO: Need to make this detect and change version
end

default['opennms']['pg_auth_method'] = 'trust'
default['opennms']['locale'] = 'en_US.UTF-8'
