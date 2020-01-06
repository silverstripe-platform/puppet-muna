class muna (
	$download_link,
	$aws_key = undef,
	$aws_secret = undef,
	$cron_enabled = false,
	$cron_minute = "0",
	$cron_hour = "*/4",
	$http_proxy = undef,
	$https_proxy = undef,
	$webroot_path = "/var/www",
	$ssl_path = "/etc/nginx/ssl",
) {
	class { 'muna::install': } ->
	class { 'muna::config': }
}
