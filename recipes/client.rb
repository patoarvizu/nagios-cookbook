node.default["nagios-host-name"] = node.name
node.save

include_recipe 'nrpe::default'

mounts_to_check = node['nagios']['mounts-to-check']
nrpe_check "check_disk" do
  parameters "-w 20% -c 10% -p #{mounts_to_check.join(' -p ')}"
end

nrpe_check "check_memory" do
  parameters "-w 30% -c 20%"
end

nrpe_check "check_load" do
  parameters "-r -w 1.0,0.85,0.70 -c 2.0,1.75,1.5"
end
