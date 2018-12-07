export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump --assume-yes
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Hey, I'm a switch!
ovs-vsctl add-br switch

# North to router-1
ovs-vsctl add-port switch eth1

# South to host-1-a
ovs-vsctl add-port switch eth2 tag=2

# South to host-1-b
ovs-vsctl add-port switch eth3 tag=3
