mac_addr_netplan=$(grep -oiE "([0-9a-z]{2}:){5}[0-9a-z]{2}" /etc/netplan/50-cloud-init.yaml)
cat <<EOF > /etc/netplan/50-cloud-init.yaml
network:
    ethernets:
        enp0s3:
            dhcp4: true
            dhcp4-overrides:
              use-routes: false
            match:
                macaddress: mac_for_replace
            set-name: enp0s3
    version: 2
EOF
sed -i "s/mac_for_replace/$mac_addr_netplan/" /etc/netplan/50-cloud-init.yaml
netplan apply