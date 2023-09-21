Note - Create secret.tfvars file which contains sp details.

### Initialize terraform

```
terraform init -upgrade
```

### Make a plan

```
terraform plan -out main.tfplan -var-file secret.tfvars
```

### Apply changes

```
terraform apply.
```

### Execute connect.ps1 file to get access of jumpbox vm.

