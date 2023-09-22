#!/bin/bash

remove_config() {
    if [ -f ~/.kube/config ]; then
        rm ~/.kube/config
        echo "Exiting config file is removed."
    else
        echo "No config file found"
    fi
}
remove_config

get_values() {
    aks_cluster_name=$(terraform output -raw aks_test)
    resource_group_name=$(terraform output -raw resource_group)
    acr_name=$(terraform output -raw acr_name)

    echo "Getting credentials....."
    az aks get-credentials --resource-group $resource_group_name --name $aks_cluster_name

    echo "Attaching ACR to the cluster....."
    az aks update -n $aks_cluster_name -g $resource_group_name --attach-acr $acr_name
}
get_values