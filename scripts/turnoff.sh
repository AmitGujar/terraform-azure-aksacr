#!/bin/bash

aksoff() {
	read -p "When do you want to stop the aks = " duration

	sleep $duration &
	az aks stop -g rg-amit-001 -n aks-test-001 &>/dev/null
	echo "Aks is being paused......"
	exit 1
}
aksoff
