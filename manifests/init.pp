class ssl {
  package { ['ca-certificates', 'ssl-cert']:
    ensure => present,
  }

  file { '/etc/ssl':
    ensure => directory,
  }

  exec { 'update-ca-certificates':
    refreshonly => true,
    path        => '/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin'
  }
}
