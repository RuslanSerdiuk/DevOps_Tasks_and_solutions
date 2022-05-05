#!/bin/sh
sudo ip route add default via 172.16.14.3
sudo apt install isc-dhcp-server -y
  # echo 'INTERFACESv4="enp0s8"' >> /etc/default/isc-dhcp-server

  echo "default-lease-time 600;
      max-lease-time 7200;
      authoritative;
  
      subnet 172.16.14.0 netmask 255.255.255.0 {
        range 172.16.14.5 172.16.14.10;
        option subnet-mask 255.255.255.0;
        option routers 172.16.14.254;
        option domain-name-servers 172.16.14.4;
      }
      subnet 172.16.13.0 netmask 255.255.255.0 {
        range 172.16.13.1 172.16.13.253;
        option subnet-mask 255.255.255.0;
        option routers 172.16.13.254;
        option domain-name-servers 172.16.14.4;
      }
      subnet 172.16.15.0 netmask 255.255.255.0 {
        range 172.16.15.1 172.16.15.253;
        option subnet-mask 255.255.255.0;
        option routers 172.16.15.254;
        option domain-name-servers 172.16.14.4;
       }
      subnet 172.16.16.0 netmask 255.255.255.0 {
        range 172.16.16.1 172.16.16.2;
        option subnet-mask 255.255.255.0;
        option routers 172.16.16.254;
        option domain-name-servers 172.16.14.4;
       }" >> /etc/dhcp/dhcpd.conf

sudo systemctl restart isc-dhcp-server
# dhcpd -t -cf /etc/dhcp/dhcpd.conf
# sudo ip route del default via 10.0.2.2 dev enp0s3 proto dhcp src 10.0.2.15 metric 100
# sudo ip route add 172.16.14.253 dev enp0s8
# sudo ip route add 172.16.15.254 dev enp0s8
# sudo ip route add 172.16.13.254 dev enp0s8

sudo ip route add 172.16.15.0/24 via 172.16.14.253
sudo ip route add 172.16.13.0/24 via 172.16.14.254
sudo ip route add 172.16.16.0/24 via 172.16.14.252
sudo systemctl restart isc-dhcp-server

#--------------------------------------------------------------------------------

cat <<'EOF' > /etc/netplan/50-vagrant.yaml
---
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      addresses:
      - 172.16.14.2/24
      gateway4: 172.16.14.3
      nameservers:
        addresses: [172.16.14.2]

EOF 

sudo systemctl restart systemd-resolved.service
netplan apply