#!/bin/bash

source ./alert.sh

cd /home/amit/terraform-azure-aksacr || exit 1

aks_cluster_name=$(terraform output -raw aks_name)
resource_group_name=$(terraform output -raw resource_group)

# appending tag to the rg
tag_addition() {
    echo "Appending tag to your node group..."
    resource_id=$(az group show -g "$resource_group_name-node-group" --query "id" -o tsv)
    az tag create --resource-id "$resource_id" --tags Exp=5
    
}

# checking if the tag exists for the rg
check_tag() {
    local check_tag
    check_tag=$(az group show -g "$resource_group_name-node-group" --query "tags.Exp" -o tsv)
    if [ -z "$check_tag" ]; then
        tag_addition
    else
        echo "This group already consists tag."
    fi
}

# removing existing config file
remove_config() {
    if [ -f ~/.kube/config ]; then
        rm ~/.kube/config
        echo "Existing config file is removed."
    else
        echo "No config file found"
    fi
}

# merging config file
get_values() {
    remove_config
    echo "Getting credentials....."
    az aks get-credentials --resource-group "$resource_group_name" --name "$aks_cluster_name"
    local acr_name
    acr_name=$(terraform output -raw acr_name)
    echo "Attaching ACR to the cluster....."
    # az aks update -n "$aks_cluster_name" -g "$resource_group_name" --attach-acr "$acr_name" || true  
}

# connecting to the aks cluster based on it's state
aks_connect() {
    check_tag
    local status
    status=$(az aks show -g "$resource_group_name" -n "$aks_cluster_name" --query "powerState.code" -o tsv)

    if [ "$status" == "Running" ]; then
        echo "Cluster is already running"
        get_values
    else
        echo "Starting your aks cluster"
        az aks start -g "$resource_group_name" -n "$aks_cluster_name"
        get_values
        send_alert "Cluster is UP ✅"
    fi
}

aks_control() {
    case $1 in
    "R")
        aks_connect
        exit 0

        ;;
    "S")
        echo "Stopping your aks cluster"
        az aks stop -g "$resource_group_name" -n "$aks_cluster_name"

        send_alert "Cluster is stopped ❌"
        exit 0
        ;;
    *)
        echo "provide values in R (Running) & S (Stopped) only "
        ;;
    esac
}

determine_job() {
    if [ -z "$1" ]; then
        aks_connect
    else
        aks_control "$1"
    fi
}
determine_job "$1"
