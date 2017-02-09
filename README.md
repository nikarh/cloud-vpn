# Terraform srcripts to set up VPN in cloud

## Clone
```sh
git clone https://github.com/nikarh/cloud-vpn.git
```

## Setup

### Digital Ocean
```sh
cd digitalocean
terraform apply # Enter region and DO token
sudo openvpn --config client.ovpn
```

