## Network Services

This stack provides the following services:

* Metadata
* DNS
* Network Manager

### Changelog for v0.2.8-1

#### Network Manager [rancher/network-manager:v0.7.20]
* Fixes issue during startup of healthcheck not able to reach server.
* Fixes issue with deletion of conntrack entries related to Kubernetes cluster IP subnet.

#### Metadata [rancher/metadata:v0.9.5]

### Configuration Options

#### dns

* `DNS_RECURSER_TIMEOUT`
* `TTL`

#### metadata

* `CPU_PERIOD`
* `CPU_QUOTA`
* `RELOAD_INTERVAL_LIMIT`
