variable "ssh_key" {
    type = "string"
    default = "~/.ssh/id_rsa"
}

variable "region" {
    type = "string"
    description  = <<EOF
Possible values: 
    ams2, ams3 (Amsterdam), 
    blr1 (Bangladore), 
    fra1 (Frankfurt), 
    lon1 (London), 
    nyc1, nyc2, nyc3 (New York), 
    sfo1, sfo2  (San Francisco), 
    sgp1 (Singapore), 
    tor1 (Toronto)
EOF
}

