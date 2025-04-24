package { 'fontconfig':
  ensure => installed,
}
package { 'openjdk-21-jre':
  ensure => installed,
}

package { 'jenkins':
	ensure => installed,
	require => [
    File['/etc/apt/sources.list.d/jenkins.list'],
    Package['openjdk-21-jre'],
  ],
}

file { '/etc/apt/sources.list.d/jenkins.list':
  ensure => file,
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
  content => 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/',
}

exec { 'updating keys for repositories':
  path        => '/usr/bin:/bin',
  command     => 
'wget -qO /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key; apt update',
  subscribe   => File['/etc/apt/sources.list.d/jenkins.list'],
  refreshonly => true,
}

service { 'jenkins':
  ensure => running,
  enable => true,
}

file { '/lib/systemd/system/jenkins.service':
  ensure => file,
  mode   => '0644',
  owner  => 'root',
  group  => 'root',
  source => "file:/root/jenkins.service",
}

exec { 'systemd-daemon-reload':
  command     => '/usr/bin/systemctl daemon-reload',
  path        => ['/usr/bin'],
  refreshonly => true,
}
