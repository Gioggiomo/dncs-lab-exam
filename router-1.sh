export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes

# Forwarding enabled
sysctl -w net.ipv4.ip_forward=1

# Setting up interface eth2 (East)
ip link set dev eth2 up
ip addr add 172.23.1.37/30 dev eth2


# Setting up interface eth1 (South)
ip link add link eth1 name eth1.7 type vlan id 7
ip link add link eth1 name eth1.8 type vlan id 8
ip link set dev eth1 up
ip link set dev eth1.7 up
ip link set dev eth1.8 up
ip addr add 172.23.0.1/24 dev eth1.7
ip addr add 172.23.1.1/27 dev eth1.8
