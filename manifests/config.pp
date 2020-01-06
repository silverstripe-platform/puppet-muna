class muna::config inherits muna {
	file { "/opt/muna/scripts/_muna_functions.php":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0640",
		content => template("muna/muna_functions.php.erb"),
		require => File['/opt/muna/scripts'],
	}
	
  file { "/opt/muna/conf/namespaces.ini":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0640",
		require => File['/opt/muna/conf'],
	}
}
