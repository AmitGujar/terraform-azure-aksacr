variable "resource_name" {
  type = string
}

variable "location" {
  type = string
}

variable "agent_count" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  default = "dns-aks-clmigration-001"
}

variable "aks_subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
}

variable "ssh_key" {
  description = "The SSH public key to use for the cluster."
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyoCY6GO9QUXeocsuN4Th/Mf5bC0gyol/LPieQbWwvVWiADJh/JPlWjssDsrUsvT48UIFRIgv20zpJfA/Tat4+a6FrWwaBTXjpiFimimMBpeV5+Vuuvgm7nCWFmPLvSXmtSY5Vqjjjp/51TYEd/1eDyTYRT3RCrdBxY6JxBvJaQo62nVsAnpWxz2vqTqrIskUlEgZxAUEFDrlTSWLSdwvtv4BarqQPYxpSfAUWljc+R2J7UZTZNohgWaf+9uQ6kQ+/loIpRiHWBkeAktGIWS3zYtYNf2TqA9j1B+aXfI0fE3WamYRuPENSZTQ6lYpd18KKFucatuQqNHv67o6NmNfGB4bnBvlOPwXzPGED3wcODWKT81tmyhsQJoYm58BtxxpyplYkrME8P2ABMSN4LH6NY4oJMJHTKJ+xCXFsdi7s2P2xf5llyrvHwdq78HKZnki/DFvoZjJaYp3rAope6t3D/G+oysbKgK7hOsL04gqqWecPs7NhnNy0diAJTO+AYkH63BM1rNY3OMsGvkAtWMqwUS0qJ9zQ8+Ymca+Ht0Qc7i3wN8RgFcGwxTMYM/ZyB60sza6B9ILEi6t97T3jcxiv3+FzjVdgwhlKWND3ajmXLqk8OdhzwIlMLBeK7PkrZIUhYClpknTucHsoT2hun6Jckacwgn2Gb1B3Ff9WmCSFeQ== amitdg@FX503"
}

variable "client_id" {
  description = "client id for aks"
}

variable "client_secret" {
  description = "value of client secret for aks"
}
