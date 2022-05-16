apt update
sudo apt-get install iptables

# ---------------------------------VERSION 0.1-----------------------------------------
 # sudo iptables -L                       // Увидеть текущие настройки iptables по умолчанию
 # sudo iptables -L | grep policy         // Расширенная версия списка
 # Если что-то менялось, а теперь нужно вернуть прежние настройки, то сделать это можно с помощью таких команд:
                                                                                                             # iptables --policy INPUT ACCEPT
                                                                                                             # iptables --policy OUTPUT ACCEPT
                                                                                                             # iptables --policy FORWARD ACCEPT
 # sudo iptables -A FORWARD -s 172.16.13.0/24 -j DROP       // блокирует доступ к подсети и доступ из подсети
 # sudo iptables -A OUTPUT -s 172.16.14.0/26 -j DROP
 # sudo iptables -I OUTPUT 1 -s 172.16.14.3,172.16.14.4,172.16.14.2 -j ACCEPT
 # sudo iptables -A FORWARD -s 172.16.14.0/24 -j DROP
 # sudo iptables -I FORWARD 1 -s 172.16.14.3,172.16.14.4,172.16.14.2 -j ACCEPT

 # sudo iptables -A FORWARD -p icmp --icmp-type echo-request -j DROP
 # sudo iptables -I FORWARD 1 -s 172.16.13.0/24 -p icmp --icmp-type echo-request -j ACCEPT




# ---------------------------------VERSION 1-----------------------------------------
 # For subnetwork 13.0/24: 
 sudo iptables -A FORWARD -s 172.16.13.0/24 -j DROP          # тебе нельзя ко мне заходить, НО я к тебе могу! tcpdump получается мои пакеты, но не дает ответа
 sudo iptables -I FORWARD 1 -s 172.16.13.0/24 -p icmp --icmp-type echo-request -j ACCEPT  # хочу видеть ответ на мой запрос и ничего больше. Тебе запрещен доступ в мою зону

 # For subnetwork 15.0/24:
 sudo iptables -A FORWARD -s 172.16.15.0/24 -j DROP
 sudo iptables -I FORWARD 1 -s 172.16.15.0/24 -p icmp --icmp-type echo-request -j ACCEPT

 # For subnetwork 14.0/24:
 sudo iptables -A FORWARD -s 172.16.14.0/24 -j DROP
 sudo iptables -I FORWARD 1 -s 172.16.14.0/24 -p icmp --icmp-type echo-request -j ACCEPT

 # Перезапуск сетевого интерйеса(вкл/выкл): sudo ip link set dev enp0s8 down ; sudo ip link set dev enp0s8 up



# ---------------------------------VERSION 2-----------------------------------------
 #  # DISABLE ACCES TO NETWORKS FROM DMZ

 #  ## RULE FOR DNS
 #  sudo iptables -N ACCEPT_DNS
 #  sudo iptables -A ACCEPT_DNS -p tcp --dport 53 -j ACCEPT
 #  sudo iptables -A ACCEPT_DNS -p udp --dport 53 -j ACCEPT

 #  ## RULE FOR DHCP 
 #  sudo iptables -N ACCEPT_DHCP
 #  sudo iptables -A ACCEPT_DHCP -p tcp -m multiport --dport 67,68 -j ACCEPT
 #  sudo iptables -A ACCEPT_DHCP -p udp -m multiport --dport 67,68 -j ACCEPT

 #  ## NET1
 #  sudo iptables -A FORWARD -s 172.16.13.0/24 -p icmp -m icmp --icmp-type 8 -j ACCEPT
 #  sudo iptables -A FORWARD -s 172.16.13.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT

 #  ## NET3
 #  sudo iptables -A FORWARD -s 172.16.15.0/24 -p icmp -m icmp --icmp-type 8 -j ACCEPT
 #  sudo iptables -A FORWARD -s 172.16.15.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT

 #  ## NET2
 #  sudo iptables -A FORWARD -s 172.16.14.0/24 -p icmp -m icmp --icmp-type 8 -j ACCEPT
 #  sudo iptables -A FORWARD -s 172.16.14.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT
 #  sudo iptables -A FORWARD -s 172.16.14.4 -j ACCEPT_DNS
 #  sudo iptables -A FORWARD -s 172.16.14.2 -j ACCEPT_DHCP


 #  sudo iptables -A FORWARD -s 172.16.13.0/24,172.16.14.0/24,172.16.15.0/24 -j DROP

# ---------------------------------VERSION 3-----------------------------------------
 #  ## RULE FOR DNS
 # sudo iptables -N ACCEPT_DNS
 # sudo iptables -A ACCEPT_DNS -p tcp --dport 53 -j ACCEPT
 # sudo iptables -A ACCEPT_DNS -p udp --dport 53 -j ACCEPT

 #  ## RULE FOR DHCP 
 # sudo iptables -N ACCEPT_DHCP
 # sudo iptables -A ACCEPT_DHCP -p tcp -m multiport --dport 67,68 -j ACCEPT
 # sudo iptables -A ACCEPT_DHCP -p udp -m multiport --dport 67,68 -j ACCEPT

 # # For subnetwork NET1 13.0/24: 
 # sudo iptables -A FORWARD -s 172.16.13.0/24 -j DROP
 # sudo iptables -I FORWARD 1 -s 172.16.13.0/24 -p icmp --icmp-type echo-request -j ACCEPT
 # sudo iptables -I FORWARD 2 -s 172.16.13.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT

 # # For subnetwork NET3 15.0/24:
 # sudo iptables -A FORWARD -s 172.16.15.0/24 -j DROP
 # sudo iptables -I FORWARD 1 -s 172.16.15.0/24 -p icmp --icmp-type echo-request -j ACCEPT
 # sudo iptables -I FORWARD 2 -s 172.16.15.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT

 # # For subnetwork NET2 14.0/24:
 # sudo iptables -A FORWARD -s 172.16.14.0/24 -j DROP
 # sudo iptables -I FORWARD 1 -s 172.16.14.0/24 -p icmp --icmp-type echo-request -j ACCEPT
 # sudo iptables -I FORWARD 2 -s 172.16.14.0/24 -p tcp -m multiport --dport 80,443 -j ACCEPT
 # sudo iptables -I FORWARD 3 -s 172.16.14.4 -j ACCEPT_DNS
 # sudo iptables -I FORWARD 4 -s 172.16.14.2 -j ACCEPT_DHCP


cat <<'EOF' > /etc/netplan/50-vagrant.yaml
---
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      addresses:
      - 172.16.14.252/24
      gateway4: 172.16.14.3
      routes:
      - to: 172.16.13.0/24
        via: 172.16.14.254
      - to: 172.16.15.0/24
        via: 172.16.14.253
    enp0s9:
      addresses:
      - 172.16.16.254/24

EOF
sudo systemctl restart systemd-resolved.service
netplan apply


# ---
# network:
#   version: 2
#   renderer: networkd
#   ethernets:
#     enp0s8:
#       addresses:
#       - 172.16.14.252/24
#     enp0s9:
#       addresses:
#       - 172.16.16.254/24