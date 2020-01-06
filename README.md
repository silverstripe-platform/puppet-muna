# puppet-muna

The puppet-muna module is responsible for downloading SSL certificates and secrets for an environment during the release process. The module will attempt to download Muna and place it in the appropriate location. Then during release, the binary is used to fetch secrets for the environment.

## Configuration

No additonal environment or Puppet variables are required unless this module is being run on an instance without an EC2 Instance Profile. If the instance isn't on EC2, then the credentials for connecting to AWS can be passed in manually.

## Types of secrets

The module supports three types of secrets, which are a holdover from the legacy Frisp backend:
* `ssenv`: Environment variables placed in locations for the SS site.
* `secrets`: Files stored in `/var/secrets`.
* `sslcert`: SSL certs for each vhost.

## Namespaces

The module allows for the configuration of namespaces, which are paths used to store secrets in when using Parameter Store, for example environment, stack, cluster, and global namespaces. These are stored in `/opt/muna/conf/namespaces.ini`, and are populated by Rainforest during the manifest compilation (for the cluster, stack, and env codes) and the Puppet run.

Each namespace has a `vhost` flag to work out whether the vault is segmented for each vhost on the environment. For example, it makes sense to have vhost-specific environment and stack secrets but vhost-specific ones in the account namespace.

## Auto-refresh

If enabled, auto-refresh will reprovision the SSL certificates every hour. This can be used by the likes of Lets Encrypt if the certificate is replaced in the environment namespace and uses the same key.
