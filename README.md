### Create secret.tfvars file which contains following details.
Required Values: 
- client_id - { client id of service principle }
- client_secret - { client secret of service principle }
- acr_name - { name for azure container registry }

Optional Values:
- resource_name - { resource group name }
- location - { location for the resource group }


### Provision Resources 

```
./aksinit
```

### Connect to the cluster

```
cd scripts/
./aks_connect.sh
```

### Execute file to get access of jumpbox vm.

```
./vm_connect.sh
```
### Execute file to clean up resources

```
./killaks
```
### NOTE - Follow above steps if you are cloning this repo. To use this module directly, follow the instructions on terrafrom registry.