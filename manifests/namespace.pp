define muna::namespace(
  $path
) {
  ini_setting { "muna_namespace_${name} path":
    ensure  => present,
    path    => '/opt/muna/conf/namespaces.ini',
    section => $name,
    setting => 'path',
    value   => $path,
    require => File['/opt/muna/conf']
  }
}
