name             'nagios'
maintainer       ''
maintainer_email 'patoarvizu@gmail.com'
license          'All rights reserved'
description      'Installs/Configures Nagios server and clients'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.0'

depends 'nagios'
depends 'nrpe'
depends 'chef-client'
depends 'poise-python'
