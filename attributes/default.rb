default['nagios']['host_name_attribute'] = "nagios-host-name"
force_default['nagios']['server']['packages'] = ["nagios3", "nagios-nrpe-plugin", "nagios-images", "nagios-plugins-contrib"]

default['nrpe']['server_role'] = "nagios-server"
default['nrpe']['multi_environment_monitoring'] = true
force_default['nrpe']['packages'] = ["nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard", "nagios-plugins-contrib"]

force_default['chef_client']['init_style'] = "none"
force_default['chef_client']['splay'] = '0'
force_default['chef_client']['cron']['log_file'] = "/var/log/chef/chef-client.log"
force_default['chef_client']['cron']['minute'] = "*"
force_default['chef_client']['cron']['hour'] = "*"
force_default['chef_client']['cron']['append_log'] = true

default['chef_client']['config'] = {
  'chef_server_url' => "https://127.0.0.1:443",
  'validation_client_name' => "chef-validator",
  'validation_key' => "/root/.chef/chef-validator.pem",
  'trusted_certs_dir' => "/root/.chef/trusted_certs",
  'client_key' => "/root/.chef/client.pem",
  'node_name' => Chef::Config[:node_name] == node['fqdn'] ? false : Chef::Config[:node_name]
}

default['nagios']['aws-checks'] = {
  :databus_load_balancer => {
    :namespace => 'ELB',
    :metric => 'HealthyHostCount',
    :dimensions => 'LoadBalancerName=helix-databus-elb',
    :period => '300',
    :statistic => 'Average',
    :critical_condition => '3:'
  },
  :dropwizard_load_balancer => {
    :namespace => 'ELB',
    :metric => 'UnHealthyHostCount',
    :dimensions => 'LoadBalancerName=lb-databus-production',
    :period => '300',
    :statistic => 'Maximum',
    :critical_condition => '0'
  },
  :helix_console_load_balancer => {
    :namespace => 'ELB',
    :metric => 'UnHealthyHostCount',
    :dimensions => 'LoadBalancerName=lb-helix-console-production',
    :period => '300',
    :statistic => 'Minimum',
    :critical_condition => '0'
  },
  :redshift_disk_space => {
    :namespace => 'Redshift',
    :metric => 'PercentageDiskSpaceUsed',
    :dimensions => 'ClusterIdentifier=helixdwh-green-prod-1',
    :period => '300',
    :statistic => 'Average',
    :warning_condition => '60',
    :critical_condition => '80'
  },
  :redshift_health_status => {
    :namespace => 'Redshift',
    :metric => 'HealthStatus',
    :dimensions => 'ClusterIdentifier=helixdwh-green-prod-1',
    :period => '300',
    :statistic => 'Minimum',
    :critical_condition => '1:'
  },
  :redshift_cpu_utilization => {
    :namespace => 'Redshift',
    :metric => 'CPUUtilization',
    :dimensions => 'ClusterIdentifier=helixdwh-green-prod-1',
    :period => '300',
    :statistic => 'Average',
    :warning_condition => '60',
    :critical_condition => '80'
  }
}

default['nagios']['kafka-jmx-checks'] = {
  :kafka_message_rate => {
    :object_name => '\"kafka.server\":name=\"AllTopicsMessagesInPerSec\",type=\"BrokerTopicMetrics\"',
    :attribute => 'FifteenMinuteRate',
    :warning_condition => '1.0:',
    :critical_condition => '0.5:'
  },
  :kafka_under_replicated_partitions => {
    :object_name => '\"kafka.server\":name=\"UnderReplicatedPartitions\",type=\"ReplicaManager\"',
    :attribute => 'Value',
    :critical_condition => '0'
  },
  :kafka_log_flush_rate => {
    :object_name => '\"kafka.log\":name=\"LogFlushRateAndTimeMs\",type=\"LogFlushStats\"',
    :attribute => 'FifteenMinuteRate',
    :critical_condition => '0:1'
  },
  :kafka_produce_requests_rate => {
    :object_name => '\"kafka.network\":name=\"Produce-RequestsPerSec\",type=\"RequestMetrics\"',
    :attribute => 'FifteenMinuteRate',
    :critical_condition => '0:5'
  },
  :kafka_partition_count => {
    :object_name => '\"kafka.server\":name=\"PartitionCount\",type=\"ReplicaManager\"',
    :attribute => 'Value',
    :critical_condition => '6'
  },
  :kafka_fetch_request_purgatory_count => {
    :object_name => '\"kafka.server\":name=\"PurgatorySize\",type=\"FetchRequestPurgatory\"',
    :attribute => 'Value',
    :warning_condition => '15000',
    :critical_condition => '20000'
  },
  :kafka_produce_total_request_time => {
    :object_name => '\"kafka.network\":name=\"Produce-TotalTimeMs\",type=\"RequestMetrics\"',
    :attribute => '99thPercentile',
    :warning_condition => '500',
    :critical_condition => '1000'
  },
  :kafka_fetch_total_request_time => {
    :object_name => '\"kafka.network\":name=\"Fetch-Consumer-TotalTimeMs\",type=\"RequestMetrics\"',
    :attribute => '99thPercentile',
    :warning_condition => '2000',
    :critical_condition => '4000'
  }
}

default['nagios']['mounts-to-check'] = ['/']
default['nagios']['kafka-ip-address'] = '10.0.0.1'
default['nagios']['kafka-jmx-port'] = '1099'
