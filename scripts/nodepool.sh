#!/bin/bash
cd $HOME/Desktop/terraform-azure-aksacr || exit 1

resource_group=$(terraform output -raw resource_group)
cluster_name=$(terraform output -raw aks_name)

read -p "How many nodepool you need = " count
read -p "Enter the name of the nodepool = " nodepool

add_nodepool() {
	echo "Adding another node pool in your cluster"
	az aks nodepool add \
		-g $resource_group \
		--cluster-name $cluster_name \
		-n $nodepool \
		--node-count $count \
		--os-sku Ubuntu
	if [ $? -ne 0 ]; then
		echo "Failed to add node pool"
	else
		echo "Nodepool added successfully"
	fi
}
add_nodepool

delete_nodepool() {
	echo "Deleting existing nodepool"
	az aks nodepool delete \
	-g $resource_group \
	--cluster-name $cluster_name \
	-n custompool \
	--no-wait
	echo "Nodepool deleted successfully."
}
#delete_nodepool
