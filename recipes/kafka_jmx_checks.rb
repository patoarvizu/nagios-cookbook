kafka_ip_address = node['nagios']['kafka-ip-address'];
kafka_jmx_port = node['nagios']['kafka-jmx-port'];

node['nagios']['kafka-jmx-checks'].each do |check, parameters|
  nrpe_check "check_#{check}" do
    command "#{node['nrpe']['plugin_dir']}/check_jmx"
    parameters '-U service:jmx:rmi:///jndi/rmi://' + kafka_ip_address + ':' + kafka_jmx_port + '/jmxrmi -O ' + parameters[:object_name] + ' -A ' + parameters[:attribute]
    warning_condition parameters[:warning_condition]
    critical_condition parameters[:critical_condition]
  end
end
