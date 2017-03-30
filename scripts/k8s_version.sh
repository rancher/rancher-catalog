#!/bin/bash

cd $(dirname $0)/../infra-templates/k8s/

FILES="./*"

for f in $FILES; do
    if [ -d $f ] ; then
        VERSION=$(grep "^  version:" $f/rancher-compose.yml | cut -d: -f2 | awk '{print $1}' | sed 's/"//g')
        if [ $VERSION == $1 ]; then
           printf "Found template version $1\n"
           printf "\nInfra images:\n"
           RANCHER_K8S_VERSION=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/k8s")
           printf "%-60s %-60s\n" "Rancher Kubernetes version:" "$RANCHER_K8S_VERSION" 
           ETCD_VERSION=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/etcd")
           printf "%-60s %-60s\n" "ETCD version:" "$ETCD_VERSION"
           HOSTNAME_UPDATER_VERSION=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/etc-host-updater")
           printf "%-60s %-60s\n" "Hostname updater version:" "$HOSTNAME_UPDATER_VERSION"
           KUBECTLD_VERSION=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/kubectld")
           printf "%-60s %-60s\n" "Kubectld version:" "$KUBECTLD_VERSION"
           RANCHER_K8S_AGENT=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/kubernetes-agent")
           printf "%-60s %-60s\n" "Rancher Kubernetes Agent version:" "$RANCHER_K8S_AGENT"
           RANCHER_LB_CONTR=$(grep "image:" $f/docker-compose.* |  awk '{print $2}' | sort | uniq | grep "rancher/lb-service-rancher")
           printf "%-60s %-60s\n" "Rancher LB Controller version:" "$RANCHER_LB_CONTR"

           printf "\nAddons:\n"

           cd $OLDPWD
           git clone http://github.com/rancher/kubernetes-package/ > /dev/null 2>&1
           
           cd kubernetes-package
           git checkout $VERSION > /dev/null 2>&1 
           if [ -d addon-templates/dashboard ]; then
                DASHBOARD_VERSION=$(grep "image:" addon-templates/dashboard/dashboard-controller.* | sed 's/\$GCR_IO_REGISTRY/gcr.io/g' | sed 's/$DOCKER_IO_REGISTRY/docker.io/g' | awk '{print $2}')
                printf "%-60s %-60s\n" "Kubernetes Addon: Kubernetes Dashboard version:" "$DASHBOARD_VERSION"
           fi
           if [ -d addon-templates/heapster ]; then
                HEAPSTER_VERSION=$(grep "image:" addon-templates/heapster/heapster-controller.* | sed 's/\$GCR_IO_REGISTRY/gcr.io/g' | sed 's/$DOCKER_IO_REGISTRY/docker.io/g' | awk '{print $2}')
                printf "%-60s %-60s\n" "Kubernetes Addon: Heapster version:" "$HEAPSTER_VERSION"
                HEAPSTER_INFLUXDB_VERSION=$(grep "image:" addon-templates/heapster/influx-grafana-controller.* | grep influxdb | sed 's/\$GCR_IO_REGISTRY/gcr.io/g' | sed 's/$DOCKER_IO_REGISTRY/docker.io/g' | awk '{print $2}')
                printf "%-60s %-60s\n" "Kuberentes Addon: Heapster InfluxDB version:" "$HEAPSTER_INFLUXDB_VERSION"
                HEAPSTER_GRAFANA_VERSION=$(grep "image:" addon-templates/heapster/influx-grafana-controller.* | grep grafana | sed 's/\$GCR_IO_REGISTRY/gcr.io/g' | sed 's/$DOCKER_IO_REGISTRY/docker.io/g' | awk '{print $2}')
                printf "%-60s %-60s\n" "Kubernetes Addon: Heapster Grafana version:" "$HEAPSTER_GRAFANA_VERSION"
           fi
           if [ -d addon-templates/helm ];then
                TILLER_VERSION=$(grep "image:" addon-templates/helm/tiller-deploy.* | sed 's/\$GCR_IO_REGISTRY/gcr.io/g' | sed 's/$DOCKER_IO_REGISTRY/docker.io/g' | awk '{print $2}')
                printf "%-60s %-60s\n" "Kubernetes Addon: Tiller version:" "$TILLER_VERSION"
           fi

           printf "\nWarn: Could not determine version of kube-dns\n"

           cd ..
           rm -rf kubernetes-package

           exit 0 
        fi 
    fi
done

printf "could not find version $1\n"
exit 1
