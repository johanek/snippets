package { 'mcollective-client':
  ensure   => installed,
  provider => rpm,
  source   => "http://downloads.puppetlabs.com/mcollective/mcollective-client-1.3.2-1.el5.noarch.rpm",
  require  => Package['rubygem-stomp','mcollective-common']
}
package { 'rubygem-stomp':
  ensure => installed
}
package { 'mcollective-common':
  ensure   => installed,
  provider => rpm,
  source   => "http://downloads.puppetlabs.com/mcollective/mcollective-common-1.3.2-1.el5.noarch.rpm",
  require  => Package['rubygem-stomp']
}
package { 'mcollective':
  ensure   => installed,
  provider => rpm,
  source   => "http://downloads.puppetlabs.com/mcollective/mcollective-1.3.2-1.el5.noarch.rpm",
  require  => Package['rubygem-stomp','mcollective-common']
}
service { 'mcollective':
  ensure    => running,
  hasstatus => true
}
file { '/etc/mcollective/server.cfg':
  owner  => 'root',
  group  => 'root',
  mode   => '0640',
  require => Exec['server-cfg'],
  notify  => Service['mcollective']
}
exec { 'server-cfg':
  cwd     => '/etc/mcollective',
  command => '/usr/bin/wget http://10.228.230.62/server.cfg -O server.cfg',
  require => Package['mcollective']
}
file { '/etc/mcollective/client.cfg':
  owner  => 'root',
  group  => 'root',
  mode   => '0644'
}
exec { 'client-cfg':
  cwd     => '/etc/mcollective',
  command => '/usr/bin/wget http://10.228.230.62/client.cfg -O client.cfg',
  require => Package['mcollective']
}
