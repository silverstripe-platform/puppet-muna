define muna::sslcert(
  $cert_key,
  $key_key,
  $cert_namespace = 'env',
  $key_namespace = 'env'
) {
	file { "/opt/muna/conf/ssl_${name}.ini":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0600",
		require => File['/opt/muna/conf'],
	}
  ini_setting { "/opt/muna/conf/ssl_${name}.ini cert_key":
    ensure  => present,
    setting => 'cert_key',
    value   => $cert_key,
    path    => "/opt/muna/conf/ssl_${name}.ini",
    require => File["/opt/muna/conf/ssl_${name}.ini"]
  }
  ini_setting { "/opt/muna/conf/ssl_${name}.ini key_key":
    ensure  => present,
    setting => 'key_key',
    value   => $key_key,
    path    => "/opt/muna/conf/ssl_${name}.ini",
    require => File["/opt/muna/conf/ssl_${name}.ini"]
  }
  ini_setting { "/opt/muna/conf/ssl_${name}.ini cert_namespace":
    ensure  => present,
    setting => 'cert_namespace',
    value   => $cert_namespace,
    path    => "/opt/muna/conf/ssl_${name}.ini",
    require => File["/opt/muna/conf/ssl_${name}.ini"]
  }
  ini_setting { "/opt/muna/conf/ssl_${name}.ini key_namespace":
    ensure  => present,
    setting => 'key_namespace',
    value   => $key_namespace,
    path    => "/opt/muna/conf/ssl_${name}.ini",
    require => File["/opt/muna/conf/ssl_${name}.ini"]
  }
}
