apt_repository "opennms" do
  uri "http://debian.opennms.org"
  components ["stable", "main"]
  key "http://debian.opennms.org/OPENNMS-GPG-KEY"
  deb_src true
  action :add
end
