#!/bin/bash

curl -sSL https://rvm.io/mpapis.asc | gpg --import - 2>&1
curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.1 2>&1
source /home/vagrant/.rvm/scripts/rvm
gem install librarian-chef

#The next two lines are a hack to patch an issue with librarian
sed -i 's/\/pax_global_header\//\/pax_global_header|PaxHeader\//g' /home/vagrant/.rvm/gems/ruby-2.2.1/gems/librarian-chef-0.0.4/lib/librarian/chef/source/site.rb
sed -i '312i\ \ \ \ \ \ \ \ \ \ \ \ Dir.glob(File.join("**", "{pax_global_header,PaxHeader}")) { |pax_directory| FileUtils.remove_dir(pax_directory) }' /home/vagrant/.rvm/gems/ruby-2.2.1/gems/librarian-chef-0.0.4/lib/librarian/chef/source/site.rb

chef-zero --host 10.0.1.2 --daemon
cd /vagrant
librarian-chef config tmp /tmp --global
librarian-chef install
knife upload /. --chef-repo-path /vagrant/ --server-url http://10.0.1.2:8889 --key /vagrant/dummy.pem --user dummy