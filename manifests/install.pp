class muna::install inherits muna {
	$muna_dirs = [
		'/opt/muna',
		'/opt/muna/bin',
		'/opt/muna/conf',
	]

	file { $muna_dirs:
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0755',
	}

	# Install the main Muna binary
	if $http_proxy {
		$proxy_environment = ["http_proxy=${http_proxy}", "https_proxy=${https_proxy}"]
	} else {
		$proxy_environment = []
	}

	exec { "muna_download":
		command => "curl -s -f ${download_link} -o /opt/muna/bin/muna",
		path => '/usr/bin:/usr/sbin:/bin',
		environment => $proxy_environment,
		onlyif => "test ! -f /opt/muna/bin/muna",
		require => File["/opt/muna/bin"]
	}

	file { '/opt/muna/bin/muna':
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0555",
		require => Exec["muna_download"]
	}

	file { "/opt/muna/scripts/":
		path => "/opt/muna/scripts/",
		ensure => directory,
		owner => "root",
		group => "root",
		mode => "755",
		source => "puppet:///modules/muna/scripts/",
		recurse => true
	}
}
