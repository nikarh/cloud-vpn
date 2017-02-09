provider "digitalocean" {
    #token = "TOKEN"
}

resource "digitalocean_ssh_key" "vpn" {
    name = "nikarh"
    public_key = "${file("${var.ssh_key}.pub")}"
}

resource "digitalocean_droplet" "vpn" {
    image = "docker"
    name = "vpn"
    region = "${var.region}"
    size = "512mb"
    ssh_keys = [
        "${digitalocean_ssh_key.vpn.fingerprint}"
    ]
    connection {
        private_key = "${file(var.ssh_key)}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "docker volume create --name ovpn",
            "docker run -v ovpn:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://${self.ipv4_address}",
            "docker run -v ovpn:/etc/openvpn --rm -it kylemanna/openvpn bash -c 'echo cloudvpn | ovpn_initpki nopass'",
            # Allow openvpn to route traffic through docker
            "docker run -v ovpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn",
            # Create client certs
            "docker run -v ovpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full client nopass",
            "docker run -v ovpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient client > client.ovpn"
        ]
    }
    provisioner "local-exec" {
        command = "ssh-keyscan -T 120 ${self.ipv4_address} >> ~/.ssh/known_hosts"
    }
    provisioner "local-exec" {
        command = "scp -i ${var.ssh_key} root@${self.ipv4_address}:client.ovpn client.ovpn"
            
    }
    provisioner "remote-exec" {
        inline = [
            "rm client.ovpn"
        ]
    }
}
