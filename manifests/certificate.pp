define ssl::certificate(
  $source,
  $ensure      = 'present',
  $private_key = 'private_key.key',
  $all_in_one  = '',
  $owner       = 'root',
  $group       = 'root',
) {

  file { "/etc/ssl/${name}/":
    ensure  => $ensure ? {
      present => 'directory',
      absent  => 'absent',
      default => $ensure,
    },
    source  => $source,
    recurse => $ensure ? {
      present => true,
      absent  => false,
      default => true,
    },
    purge   => true,
    force   => true,
    owner   => $owner,
    group   => $group,
    mode    => '0644',
  }

  if $ensure == 'present' {
    file { "/etc/ssl/${name}/${private_key}":
      ensure => 'present',
      source => "${source}/${private_key}",
      owner  => $owner,
      group  => $group,
      mode   => '0640',
    }

    if $all_in_one {
      file { "/etc/ssl/${name}/${all_in_one}":
        ensure => 'present',
        source => "${source}/${all_in_one}",
        owner  => $owner,
        group  => $group,
        mode   => '0640',
      }
    }
  }
}
