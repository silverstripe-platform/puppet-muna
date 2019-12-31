class muna (
	$aws_key,
	$aws_secret,
	$download_link,
	$cron_enabled = false,
	$cron_minute = "0",
	$cron_hour = "*/4",
	$http_proxy,
	$https_proxy,
	$webroot_path = "/var/www",
	$ssl_path = "/etc/nginx/ssl",
) {
	class { 'muna::install': } ->
	class { 'muna::config': }
}
