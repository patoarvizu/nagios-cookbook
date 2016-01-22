# nagios-cookbook

Wrapper cookbook for the nagios and nrpe cookbooks. The nagios checks are derived mostly from the attributes and data bags.

The _client_ and _server_ recipes should be self-explanatory. The _solo\_client_, _aws\_checks_ and _kafka\_jmx\_checks_ are used to provision a machine that collects metrics from different services at a single point.
