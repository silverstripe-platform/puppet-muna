define muna::namespace(
  $path,
  $vhost = false,
) {
  ini_setting { "muna_namespace_${name} path":
    ensure  => present,
    path    => '/opt/muna/conf/namespaces.ini',
    section => $name,
    setting => 'path',
    value   => $path,
    require => File['/opt/muna/conf/namespaces.ini']
  }
  ini_setting { "muna_namespace_${name} vhost":
    ensure  => present,
    path    => '/opt/muna/conf/namespaces.ini',
    section => $name,
    setting => 'vhost',
    value   => $vhost,
    require => File['/opt/muna/conf/namespaces.ini']
  }
}
