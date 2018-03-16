## Rancher EBS

### Changelog - 0.5.0

#### Rancher EBS [rancher/storage-ebs:v0.9.1]
 * Switched to stop using docker volumes and uses flex volumes

### Restrictions when using EBS

An AWS EBS volume can only be attached to a single AWS EC2 instance. Therefore, all containers using the same AWS EBS volume will be scheduled on the same host.

[Read more about how to use EBS](http://rancher.com/docs/rancher/v1.6/en/rancher-services/storage-service/rancher-ebs/)
