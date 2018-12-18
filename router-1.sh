#export DEBIAN_FRONTEND=noninteractive
#apt-get update
#apt-get install -y tcpdump curl traceroute --assume-yes

export DEBIAN_FRONTEND=noninteractive
apt-get update
#sudo 
apt-get install -y tcpdump apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
wget -O- https://apps3.cumulusnetworks.com/setup/cumulus-apps-deb.pubkey | apt-key add -
#sudo 
add-apt-repository add-apt-repository "deb [arch=amd64] https://apps3.cumulusnetworks.com/repos/deb $(lsb_release -cs) roh-3"
#echo "deb [arch=amd64] https://apps3.cumulusnetworks.com/repos/deb $(lsb_release -cs) roh-3" >> /etc/apt/sources.list.d/cumulus-apps-deb-$(lsb_release -cs).list
apt-get update
#sudo 
apt-get install -y frr --assume-yes --force-yes

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

#ip route del default
#ip route add default via 172.23.1.38
# Adding reachability to the network where host-2-c is
ip route add 172.23.1.32/30 via 172.23.1.38


