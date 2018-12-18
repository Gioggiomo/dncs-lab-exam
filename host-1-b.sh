export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump --assume-yes
apt-get install -y curl --assume-yes

# Setting up eth1 interface (North)
ip link set dev eth1 up

# What's my address?
ip addr add 172.23.1.2/27 dev eth1

# Where should I go?
ip route del default
ip route add default via 172.23.1.1


