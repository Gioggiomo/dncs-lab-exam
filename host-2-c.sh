export DEBIAN_FRONTEND=noninteractive

#apt-get update
#apt-get install -y apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) #stable"
#apt-get update
#apt-get install -y docker-ce --assume-yes --force-yes


apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88 | grep docker@docker.com || exit 1
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce --assume-yes --force-yes


# Check for an html page. If there is not, it is automatically downloaded

# https://hub.docker.com/_/nginx/
#docker run --name docker-nginx -p 8080:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx

# Setting docker ports
docker run --name some-nginx -p 8080:80 -v /some/content:/usr/share/nginx/html:ro -d nginx 


# Setting up eth1 interface (North)
ip link set dev eth1 up

# What's my address?
ip addr add 172.23.1.34/30 dev eth1

# Where should I go?
ip route del default
ip route add default via 172.23.1.33
