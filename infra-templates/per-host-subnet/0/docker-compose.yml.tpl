version: '2'
services:
  per-host-subnet:
    privileged: true
    pid: host
    network_mode: host
    image: rancher/net:v0.13.0
    command: per-host-subnet
    environment:
      RANCHER_DEBUG: '${RANCHER_DEBUG}'
      RANCHER_METADATA_ADDRESS: '${RANCHER_METADATA_ADDRESS}'
      RANCHER_ENABLE_ROUTE_UPDATE: '${RANCHER_ENABLE_ROUTE_UPDATE}'
      RANCHER_ROUTE_UPDATE_PROVIDER: '${RANCHER_ROUTE_UPDATE_PROVIDER}'
    logging:
      driver: json-file
      options:
        max-size: 25m
        max-file: '2'
    labels:
      io.rancher.scheduler.global: 'true'
  cni-driver:
    privileged: true
    image: rancher/net:v0.13.0
    command: sh -c "touch /var/log/rancher-cni.log && exec tail ---disable-inotify -F /var/log/rancher-cni.log"
    network_mode: host
    pid: host
    volumes:
    - /var/lib/rancher/per_host_subnet:/var/lib/cni/networks
    labels:
      io.rancher.network.cni.binary: 'rancher-bridge'
      io.rancher.container.dns: 'true'
      io.rancher.scheduler.global: 'true'
    logging:
      driver: json-file
      options:
        max-size: 25m
        max-file: '2'
    network_driver:
      name: Rancher Per Host Subnet
      default_network:
        name: per-host-subnet
        host_ports: true
      cni_config:
        '10-per-host-subnet.conf':
          name: per-host-subnet-network
          type: rancher-bridge
          bridge: ${BRIDGE}
          bridgeSubnet: "__host_label__: io.rancher.network.per_host_subnet.subnet"
          isDebugLevel: ${RANCHER_DEBUG}
          logToFile: /var/log/rancher-cni.log
          isDefaultGateway: true
          hostNat: {{ .Values.HOST_NAT  }}
          hairpinMode: {{  .Values.RANCHER_HAIRPIN_MODE  }}
          promiscMode: {{ .Values.RANCHER_PROMISCUOUS_MODE  }}
          mtu: ${MTU}
          ipam:
            type: rancher-host-local-ipam
            subnet: "__host_label__: io.rancher.network.per_host_subnet.subnet"
            rangeStart: "__host_label__: io.rancher.network.per_host_subnet.range_start"
            rangeEnd: "__host_label__: io.rancher.network.per_host_subnet.range_end"
            isDebugLevel: ${RANCHER_DEBUG}
            logToFile: /var/log/rancher-cni.log
