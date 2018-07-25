## Network Services

This stack provides the following services:

* Metadata
* DNS
* Network Manager

### Changelog for v0.2.10

#### Network Manager [rancher/network-manager:v0.7.22]
* Fixed an issue with iptables rules when accessing expose port from self host.
* Added loglevel to the service to help with debugging

#### Metadata [rancher/metadata:v0.10.4]
* Added loglevel to the service to help with debugging

#### DNS [rancher/dns:v0.17.4]
* Added loglevel to the service to help with debugging

### Configuration Options

#### dns

* `DNS_RECURSER_TIMEOUT`
* `TTL`

#### metadata

* `CPU_PERIOD`
* `CPU_QUOTA`
* `RELOAD_INTERVAL_LIMIT`
