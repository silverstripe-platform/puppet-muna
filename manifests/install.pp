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
		command => "wget -q ${download_link} -O /opt/muna/bin/muna",
		path => '/usr/bin:/usr/sbin:/bin',
		environment => $proxy_environment,
		onlyif => "test ! -f /opt/muna/bin/muna"
	}

	file { '/opt/muna/bin/muna':
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0555"
	}

	file { "/opt/muna/scripts":
		path => "/opt/muna/scripts",
		ensure => directory,
		owner => "root",
		group => "root",
		mode => "755",
		source => "puppet:///modules/muna/scripts",
		recurse => true
	}

	if $cron_enabled {
		# Set up cron for pulling in secrets automatically if required
		file { "/etc/cron.d/muna-update-secrets":
			ensure => file,
			owner => "root",
			group => "root",
			mode => "0644",
			content => "${cron_minute} ${cron_hour} * * * root /opt/muna/scripts/provision.sh ${environmentname} | logger -t muna\n",
		}
	}
}
