Rancher Per-Host-Subnet Networking
=================================

### Requirements
Prepare a number of subnets for hosts. Each host installed Rancher Agent will need a subnet assigned. There cannot be overlap between the subnets. Each subnet must be routable to any other subnet, normally it will be done by programming the switch.

### Deployments

#### Adding a host to Rancher environment
1. In `Infrastructure->Hosts->Add Host`, select `Custom`, take a note of the related `docker run` command. It will look like:
    ```
    sudo docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.5 http://172.31.5.93:8080/v1/scripts/04033066C0164CF25094:1483142400000:KQrf2wQfJtdKxLHYuprV6LfWuQ
    ```
2. For each host to be added in the environment, user must add a specific Host-Subnet label. The label key is `io.rancher.network.per_host_subnet.cidr`, and the value is host's subnet CIDR. User need to add an additional parameter for the label to the command in step 1.

   For example, for a host with subnet `192.168.100.0/24`, the additional parameter will be: `-e CATTLE_HOST_LABELS='io.rancher.network.per_host_subnet.subnet=192.168.100.0/24'`

   The final command will look like:
    ```
    sudo docker run -e CATTLE_HOST_LABELS='io.rancher.network.per_host_subnet.subnet=192.168.100.0/24'  --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.5 http://172.31.5.93:8080/v1/scripts/04033066C0164CF25094:1483142400000:KQrf2wQfJtdKxLHYuprV6LfWuQ
    ```

Done!

#### About host labels in per-host-subnet networking:

io.rancher.network.per_host_subnet.subnet(required): 192.168.100.0/24

io.rancher.network.per_host_subnet.range_start(optional): 192.168.100.20

io.rancher.network.per_host_subnet.range_end(optional): 192.168.100.200

io.rancher.network.per_host_subnet.gateway(optional): 192.168.100.1 (It will be the first IP address in the subnet if not specified)
