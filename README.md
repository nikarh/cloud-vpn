# Terraform srcripts to set up VPN in cloud

## Clone
`sh
git clone https://github.com/nikarh/cloud-vpn.git
`

## Setup

### Digital Ocean
`sh
cd digitalocean

terraform apply # Enter region, your do token and optionally provide ssh key to connect to machine

# Terraform provisioner will generate vpn certificate on a server and copy it to local machine over ssh

# Start OpenVPN
openvpn --config client.ovpn
`

