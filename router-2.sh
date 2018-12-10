export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump curl traceroute --assume-yes

# Abilito il forwarding
sysctl -w net.ipv4.ip_forward=1

# Setting up interface eth1 (South)
ip link set dev eth1 up
ip addr add 172.23.1.33/30 dev eth1

# Setting up interface eth2 (West)
ip link set dev eth2 up
ip addr add 172.23.1.38/30 dev eth2

# set router-1 ad default router
ip route del default
ip route add default via 172.23.1.37
