include_recipe "apt::default"
if platform?("ubuntu") || platform?("debian")
  include_recipe "apt::default"
  apt_repository "opennms" do
		uri "http://debian.opennms.org"
		components [node[:onmsrepo][:release], "main"]
		key "http://debian.opennms.org/OPENNMS-GPG-KEY"
		deb_src true
		action :add
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end
