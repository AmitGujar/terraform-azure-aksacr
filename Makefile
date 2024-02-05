.PHONY: all aksinit aks_connect
all: aksinit aks_connect

aksinit:
	@echo "Initializing AKS Cluster"
	@./scripts/aksinit
	@echo "Current folder is: $(shell pwd)"

aks_connect:
	@echo "Connecting to AKS Cluster"
	@./scripts/aks_connect.sh