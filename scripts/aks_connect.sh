#!/bin/bash

cd ..

aks_cluster_name=$(terraform output -raw aks_test)
resource_group_name=$(terraform output -raw resource_group)

remove_config() {
    if [ -f ~/.kube/config ]; then
        rm ~/.kube/config
        echo "Existing config file is removed."
    else
        echo "No config file found"
    fi
}
remove_config

get_values() {
    acr_name=$(terraform output -raw acr_test)
    echo "Getting credentials....."
    az aks get-credentials --resource-group $resource_group_name --name $aks_cluster_name
    #    echo "Attaching ACR to the cluster....."
    #   az aks update -n $aks_cluster_name -g $resource_group_name --attach-acr $acr_name
}
get_values

aks_connect() {
    kubectl get nodes &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Starting your aks cluster...."
        az aks start -n $aks_cluster_name -g $resource_group_name &>/dev/null
        if [ $? -ne 0 ]; then 
            echo "Cluster is in Starting or Running State"
        else
            get_values
        fi
    else
        echo "Cluster is already running...."
    fi
}