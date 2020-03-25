class muna::config inherits muna {
	if $enabled {
		file { "/opt/muna/.enabled":
			ensure => file,
			owner => "root",
			group => "root",
			mode => "0640"
		}
	}

	file { "/opt/muna/scripts/_muna_functions.php":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0600",
		content => template("muna/muna_functions.php.erb"),
		require => File['/opt/muna/scripts/'],
	}
	
  file { "/opt/muna/conf/namespaces.ini":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0600",
		require => File['/opt/muna/conf'],
	}
}
