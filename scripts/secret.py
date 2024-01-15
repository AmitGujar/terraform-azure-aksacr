from kubernetes import client, config
from kubernetes.client import ApiException
import os
import json

# getting terraform output
def get_terraform_output(output_var, directory="."):
    output = os.popen(f'terraform -chdir={directory} output -json').read()
    output_json = json.loads(output)
    return output_json[output_var]['value']

# get output from terraform variables
storageName = get_terraform_output("storage_account_name", "..")
storageKey = get_terraform_output("storage_account_key", "..")

print(storageName)
print(storageKey)

# creating namespace
def create_ns(namespace):
    config.load_kube_config()
    v1 = client.CoreV1Api()
    body = client.V1Namespace(metadata=client.V1ObjectMeta(name=namespace))
    try:
        v1.read_namespace(name=namespace)
        print(f"{namespace} namespace exists!")
    except ApiException as e:
        if e.status == 404:
            body = client.V1Namespace(metadata=client.V1ObjectMeta(name=namespace))
            v1.create_namespace(body=body)
            print(f"{namespace} namespace created!")
        else:
            raise Exception("Failed to create a secret: {}".format(e))


def create_secret(namespace, name, storagekey):
    # Configure k8s client
    config.load_kube_config()

    # Create a V1Secret object
    secret = client.V1Secret()
    secret.metadata = client.V1ObjectMeta(name=name) # storage account name will be secret name
    secret.string_data = {"accountname": name, "accountkey": storagekey}  

    # Creating the secret
    v1 = client.CoreV1Api()
    try:
        v1.create_namespaced_secret(namespace=namespace, body=secret)
        print("Secret created!")
    except ApiException as e:
        raise Exception("Failed to create a secret: {}".format(e))
            

# getting created secrets
def get_secrets(namespace):

    config.load_kube_config()

    v1 = client.CoreV1Api()

    try:
        secrets = v1.list_namespaced_secret(namespace=namespace)
        print("Secrets in the namespace {} are: ".format(namespace))
        for secret in secrets.items:
            print(secret.metadata.name)
    except ApiException as e:
        raise Exception("Failed to get secrets: {}".format(e))


namespace = "elastic-deployment" #name of namespace
create_ns(namespace)
create_secret(namespace, storageName, storageKey)
get_secrets(namespace)
