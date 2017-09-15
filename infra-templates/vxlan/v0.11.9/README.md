## VXLAN Networking

Rancher networking plugin using VXLAN overlay.

### Open Ports

Traffic to and from hosts requires UDP port `4789` to be open.

### Configuration options
* `RANCHER_DEBUG`

#### cni-driver

* `DOCKER_BRIDGE`
* `MTU`
* `SUBNET`
* `RANCHER_HAIRPIN_MODE`
* `RANCHER_PROMISCUOUS_MODE`
* `HOST_PORTS`
* `SUBNET_PREFIX`
