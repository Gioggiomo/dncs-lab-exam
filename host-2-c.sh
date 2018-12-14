export DEBIAN_FRONTEND=noninteractive
#apt-get update
#apt-get install -y tcpdump --assume-yes

#apt-get install -y apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#apt-get update
#apt-get install -y docker-ce --assume-yes --force-yes

apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo apt-key fingerprint 0EBFCD88 | grep docker@docker.com || exit 1
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

#apt install apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic test"
#apt-get update
#apt install docker-ce --assume-yes --force-yes

# Setting up eth1 interface (North)
ip link set dev eth1 up

# What's my address?
ip addr add 172.23.1.34/30 dev eth1

# Where should I go?
ip route del default
ip route add default via 172.23.1.33
