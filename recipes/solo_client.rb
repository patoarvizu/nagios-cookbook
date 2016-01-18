include_recipe 'poise-python'

python_package 'nagios-cloudwatch-plugin'

cloudwatch_credentials = data_bag_item("aws", "cloudwatch")

template "/etc/boto.cfg" do
  source "boto.cfg.erb"
  variables({
    :aws_access_key_id => cloudwatch_credentials['aws_access_key_id'],
    :aws_secret_access_key => cloudwatch_credentials['aws_secret_access_key']
  })
end

package ["unzip", "dos2unix"]

src_filename = "nagios-jmx-plugin.zip"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "/opt/nagios-jmx-plugin"

remote_file src_filepath do
  source "http://snippets.syabru.ch/nagios-jmx-plugin/download/#{src_filename}"
  checksum "412b49bb4f6d0f4270ca6f49f8b6550fa9ea3a08c92f2ef3693af3be389f2086"
  owner 'root'
  group 'root'
end

bash 'install-jmx-plugin' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    unzip #{src_filename} -d #{extract_path}
    mv #{extract_path}/*/* #{extract_path}
    chmod +x #{extract_path}/check_jmx
    chmod +r #{extract_path}/check_jmx.jar
    dos2unix #{extract_path}/check_jmx
    EOH
  not_if { ::File.exists?(extract_path) }
end

link "#{node['nrpe']['plugin_dir']}/check_jmx" do
  to "#{extract_path}/check_jmx"
  owner "root"
  group "root"
end

link "#{node['nrpe']['plugin_dir']}/check_jmx.jar" do
  to "#{extract_path}/check_jmx.jar"
  owner "root"
  group "root"
end