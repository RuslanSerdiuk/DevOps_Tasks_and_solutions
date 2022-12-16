      echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/60-routing.conf

      sysctl --system

      sudo ip route add 172.16.13.0/24 via 172.16.14.254
      sudo ip route add 172.16.15.0/24 via 172.16.14.253
      sudo ip route add 172.16.16.0/24 via 172.16.14.252

      # ip route add 172.16.13.0/24 dev enp0s8
      # ip route add 172.16.15.0/24 dev enp0s8

      sudo iptables -t nat -A POSTROUTING -o enp0s9 -j MASQUERADE

      sudo iptables -t nat -A PREROUTING -p tcp -i enp0s9 --dport 80 -j DNAT --to-destination 172.16.16.1-172.16.16.2


cat <<'EOF' > /etc/netplan/50-vagrant.yaml
---
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      addresses:
      - 172.16.14.3/24
      routes:
      - to: 172.16.13.0/24
        via: 172.16.14.254
      - to: 172.16.15.0/24
        via: 172.16.14.253
      - to: 172.16.16.0/24
        via: 172.16.14.252
    enp0s9:
      dhcp4: true

EOF
sudo systemctl restart systemd-resolved.service
netplan apply