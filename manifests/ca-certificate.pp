define ssl::ca-certificate($ensure = 'present', $source = '', $content = '') {
    File {
        owner   => root,
        group   => root,
        notify  => Exec['update-ca-certificates'],
        require => Package['ca-certificates'],
    }

    if ($content) {
        file { "/usr/local/share/ca-certificates/${name}":
            content => $content,
        }
    }
    else {
        file { "/usr/local/share/ca-certificates/${name}":
            source => $source,
        }
    }
}