node['nagios']['aws-checks'].each do |check, parameters|
  nrpe_check "check_#{check}" do
    command "/usr/local/bin/check_cloudwatch.py"
    parameters "--region=us-east-1 --namespace=AWS/#{parameters[:namespace]} --metric=#{parameters[:metric]} --dimensions=#{parameters[:dimensions]} --period=#{parameters[:period]} --statistic=#{parameters[:statistic]}"
    warning_condition parameters[:warning_condition]
    critical_condition parameters[:critical_condition]
  end
end
