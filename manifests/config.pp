class muna::config inherits muna {
	file { "/opt/muna/scripts/_muna_functions.php":
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0400",
		content => template("muna/muna_functions.php.erb"),
		require => File['/opt/muna/scripts'],
	}
}
