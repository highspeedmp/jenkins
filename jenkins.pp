package { 'fontconfig':
  ensure => installed,
  before => Package['jenkins'],
}
package { 'openjdk-21-jre':
  ensure => installed,
  before => Package['jenkins'],
}
exec { 'update-keys':
  path        => '/usr/bin:/bin',
  command     => 
'wget -qO /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key; apt update',
  subscribe   => File['/etc/apt/sources.list.d/jenkins.list'],
  refreshonly => true,
}
file { '/etc/apt/sources.list.d/jenkins.list':
  ensure  => file,
  mode    => '0644',
  owner   => 'root',
  group   => 'root',
  content => 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/',
  notify  => Exec['update-keys'],
  before  => Package['jenkins'],
}

package { 'jenkins':
	ensure => installed,
	require => [
    File['/etc/apt/sources.list.d/jenkins.list'],
    File['/lib/systemd/system/jenkins.service'],
    Package['openjdk-21-jre'],
    Package['fontconfig'],
  ],
}

service { 'jenkins':
  ensure  => running,
  enable  => true,
  Require => Package['jenkins'],
}

file { '/lib/systemd/system/jenkins.service':
  ensure => file,
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
  source => "file:/root/jenkins.service",
  notify => Exec['systemd-daemon-reload'],
}

exec { 'systemd-daemon-reload':
  command     => '/usr/bin/systemctl daemon-reload',
  path        => ['/usr/bin'],
  refreshonly => true,
}
