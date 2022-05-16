#systemd-resolve --status | grep Current :SHOW CURRENT DNS SERVER
#rndc reload
#rndc dumpdb -all && cat /var/cache/bind/named_dump.db
sudo ip route add default via 172.16.14.3
sudo apt update -y
sudo apt-get install bind9 -y
ufw allow bind9


cat <<EOF > /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";
        listen-on {172.16.14.0/24; 127.0.0.1;};
        allow-recursion {none; };
        version "DNS SERVER.Ruslan Serdiuk";
        forwarders { 10.23.0.3; };
};
EOF
cat <<EOF > /etc/bind/named.conf.local
zone 	"ruslanserdiukdevops.org" IN {
		type master;
		file	"/etc/bind/db.ruslanserdiukdevops.org";
 };

zone "ruslan.net" {
		type master;
		file "/etc/bind/db.ruslan.net";
};
EOF

cat <<'EOF' > /etc/bind/db.ruslan.net
;
; BIND data file for local loopback interface
;
$TTL	604800
@		IN		SOA		ns.ruslan.net. root.ruslan.net. (
							  2			; Serial
					     604800			; Refresh
					      86400			; Retry
					    2419200			; Expire
					     604800 )		; Negative Cache TTL
;
@		IN		NS		ns.ruslan.net.
@		IN		A		172.16.14.4
ns		IN 		A		172.16.14.4
EOF
# named-checkzone ruslan.net /etc/bind/db.ruslan.net
cat <<'EOF' > /etc/bind/db.ruslanserdiukdevops.org
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     ns.ruslanserdiukdevops.org. root.ruslanserdiukdevops.org. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
        IN      NS      ns.ruslanserdiukdevops.org.
ns		IN 		A		172.16.14.4
$TTL 10 
ruslanserdiukdevops.org. IN A 172.16.16.1
ruslanserdiukdevops.org. IN A 172.16.16.2
EOF
chown bind:bind /etc/bind/*
rndc reload
systemctl restart named
systemctl restart bind9


cat <<'EOF' > /etc/netplan/50-vagrant.yaml
---
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      addresses:
      - 172.16.14.4/24
      gateway4: 172.16.14.3
      nameservers:
        addresses: [172.16.14.4]

EOF
sudo systemctl restart systemd-resolved.service
netplan apply

# sudo vim /etc/netplan/50-vagrant.yaml