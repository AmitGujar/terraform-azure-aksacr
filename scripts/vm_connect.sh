terraform output -raw tls_private_key > id_rsa

publicip=$(terraform output -raw public_ip_address)

hostname=$(echo "$publicip" | tr -d '"')

ssh -i id_rsa "amitgujar@$hostname"
