#!/bin/bash

cd /vagrant
knife upload /data_bags --chef-repo-path /vagrant/ --server-url http://10.0.1.2:8889 --key /vagrant/dummy.pem --user dummy 2>&1
knife upload /roles --chef-repo-path /vagrant/ --server-url http://10.0.1.2:8889 --key /vagrant/dummy.pem --user dummy 2>&1
knife upload /environments --chef-repo-path /vagrant/ --server-url http://10.0.1.2:8889 --key /vagrant/dummy.pem --user dummy 2>&1
knife cookbook upload nagios --cookbook-path /vagrant/cookbooks --server-url http://10.0.1.2:8889 --key /vagrant/dummy.pem --user dummy 2>&1
