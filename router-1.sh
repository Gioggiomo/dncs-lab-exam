export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes

# Forwarding enabled
sysctl -w net.ipv4.ip_forward=1

# Setting up interface eth2 (East)
ip link set dev eth2 up
ip addr add 172.23.1.37/30 dev eth2


# Setting up interface eth1 (South)
ip link add link eth1 name eth1.2 type vlan id 2
ip link add link eth1 name eth1.3 type vlan id 3
ip link set dev eth1 up
ip link set dev eth1.2 up
ip link set dev eth1.3 up
ip addr add 172.23.1.1/24 dev eth1.2
ip addr add 172.23.0.1/27 dev eth1.3
