output "VPN server IP address" {
    value = "${digitalocean_droplet.vpn.ipv4_address}"
}
output "Connect using" {
    value = "openvpn --config client.ovpn"
}
