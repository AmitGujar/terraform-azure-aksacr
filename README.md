### Note -
This repo is no longer in development. I will be releasing a new module which will be a huge upgrade over this module. 

### Create secret.tfvars file which contains following details.
Required Values: 
- client_id - { client id of service principle }
- client_secret - { client secret of service principle }
- acr_name - { name for azure container registry }
- ssh_public_key - { ssh public key }

Optional Values:
- resource_name - { resource group name }
- location - { location for the resource group }

### Create & Connect to the cluster

```
make
```

### Execute file to clean up resources

```
./killaks
```

### NOTE - Follow above steps if you are cloning this repo. To use this module directly, follow the instructions on terrafrom registry.
