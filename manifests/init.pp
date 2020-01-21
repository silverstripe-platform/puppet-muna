class muna (
	$download_link,
	$aws_key = undef,
	$aws_secret = undef,
	$http_proxy = undef,
	$https_proxy = undef,
	$webroot_path = "/var/www",
	$ssl_path = "/etc/nginx/ssl",
) {
	class { 'muna::install': } ->
	class { 'muna::config': }
}
