case platform
when "redhat", "centos", "scientific", "fedora", "suse", "amazon", "oracle"
  default[:opennms][:jdk_package] = '' # TODO: Need to find default package name
  default[:opennms][:opennms_home] = '/opt/opennms'
  default[:opennms][:pg_hba_location] = '/var/lib/postgresql/9.1/main/pg_hba.conf' # TODO: Need to validate location
when "debian", "ubuntu"
  default[:opennms][:jdk_package] = 'openjdk-7-jdk'
  default[:opennms][:opennms_home] = '/usr/share/opennms'
  default[:opennms][:pg_hba_location] = '/etc/postgresql/9.1/main/pg_hba.conf' #TODO: Need to make this detect and change version
end

default[:opennms][:pg_auth_method] = 'trust'
default[:opennms][:locale] = 'en_US.UTF-8'
