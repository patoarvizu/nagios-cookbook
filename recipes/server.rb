user 'nagios'
group 'sysadmin' do
  members 'nagios'
end

include_recipe 'nagios::default'
if node.chef_environment != "dev"
  include_recipe 'nagios::pagerduty'

  nagios_command 'notify-service-by-pagerduty' do
    options 'command_line' => ::File.join(node['nagios']['plugin_dir'], 'notify_pagerduty.pl') + ' enqueue -f pd_nagios_object=service -f SERVICESTATE="$SERVICESTATE$"'
  end

  nagios_command 'notify-host-by-pagerduty' do
    options 'command_line' => ::File.join(node['nagios']['plugin_dir'], 'notify_pagerduty.pl') + ' enqueue -f pd_nagios_object=host -f HOSTSTATE="$HOSTSTATE$"'
  end
end