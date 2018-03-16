## Rancher Secrets

### Changelog - 0.0.3

#### Rancher Secrets [rancher/storage-secrets:v0.9.1]
 * Switched to stop using docker volumes and uses flex volumes

### Encryption Backend Configuration
By default, Rancher server is configured to use a locally stored AES256 encryption key to perform the encryption of secrets. These encrypted values are stored in the MySQL database that Rancher server uses.

Instead of using the locally stored key, Rancher can be configured to use [Vault Transit](https://www.vaultproject.io/docs/secrets/transit/) to perform the encryption. [Read more about how to install Rancher using Vault Transit.](http://rancher.com/docs/rancher/v1.6/en/cattle/secrets/)


[Read more about how to create secrets](http://rancher.com/docs/rancher/v1.6/en/cattle/secrets/#creating-secrets)
