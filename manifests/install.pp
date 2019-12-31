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
		mode => '0750',
	}

	# Install the main Muna binary
	exec { "muna_download":
		command => "wget -q ${download_link} -O /opt/muna/bin/muna",
		path => '/usr/bin:/usr/sbin:/bin',
		environment => ["https_proxy=${https_proxy}","http_proxy=${http_proxy}"],
		onlyif => "test ! -f /opt/muna/bin/muna"
	}

	file { '/opt/muna/bin/muna':
		ensure => file,
		owner => "root",
		group => "root",
		mode => "0744"
	}

	file { "/opt/muna/scripts":
		path => "/opt/muna/scripts",
		ensure => directory,
		owner => "root",
		group => "root",
		mode => "0700",
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
