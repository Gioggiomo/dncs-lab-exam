# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```

    +-------------------------------------------------------------------------------------+
    |                                                                                 eth0|
+---+---+                       +-------------+                                    +------+------+
|       |                       |             |                                    |             |
|       |                  eth0 |             |      eth2                eth2      |             |
|       +-----------------------+  router-1   +------------------------------------+  router-2   |
|       |                       |             | 172.23.1.37/30      172.23.1.36/30 |             |
|       |                       |             |                                    |             |
|       |                       +------+------+                                    +------+------+
|       |                              |                                                  |
|       |                   eth1.2     |     eth1.3                                  eth1 | 172.23.1.33/30
|       |                              |                                                  |
|       |               172.23.0.1/24  |  172.23.1.1/27                                   |
|   M   |                              |                                                  |
|   A   |                              |                                                  |
|   N   |                              |                                                  |
|   A   |                              |                                                  |
|   G   |                              |                                                  |
|   E   |                              |                                                  |
|   M   |                              |                                             eth1 | 172.23.1.34/30
|   E   |                              |eth1                                              |
|   N   |                 +------------+------------+                              +------+------+
|   T   |            eth0 |                         |                              |             |
|       +-----------------+         Switch          |                              |             |
|   V   |                 |                         |                              |  host-2-c   |
|   A   |                 +--+-------------------+--+                              |             |
|   G   |                    | eth2         eth3 |                                 |             |
|   R   |                    |                   |                                 +------+------+
|   A   |                    |                   |                                        |
|   N   |                    |                   |                                    eth0|
|   T   |                    |                   |                                        |
|       |                    |                   |                                        |
|       |         eth1.2     |                   |    eth1.3                              |
|       |                    |                   |                                        |
|       |      172.23.0.2/24 |                   | 172.23.1.2/27                          |
|       |             +------+------+     +------+------+                                 |
|       |             |             |     |             |                                 |
|       |        eth0 |             |     |             |                                 |
|       +-------------+  host-1-a   |     |  host-1-b   |                                 |
|       |             |             |     |             |                                 |
|       |             |             |     |             |                                 |
+-+---+-+             +-------------+     +-------------+                                 |
  |   |                                      eth0|                                        |
  |   +------------------------------------------+                                        |
  |                                                                                       |
  +---------------------------------------------------------------------------------------+

```

# Requirements
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/dustnic/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab]$ vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 6 VMs
```
[~/dncs-lab]$ vagrant status
Current machine states:

router-1                  running (virtualbox)
router-2                  running (virtualbox)
switch                    running (virtualbox)
host-1-a                  running (virtualbox)
host-1-b                  running (virtualbox)
host-2-c                  running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them by typing:
`vagrant ssh router-1`
`vagrant ssh router-2`
`vagrant ssh switch`
`vagrant ssh host-1-a`
`vagrant ssh host-1-b`
`vagrant ssh host-2-c`

# Description of the problem
To complete this assignment, we are asked to design a functioning network where any host configured and attached to router-1 (through switch) can browse a website hosted on host-2-c.
The requirements we are asked to respect are the following:
 - Up to 130 hosts in the same subnet of host-1-a
 - Up to 25 hosts in the same subnet of host-1-b
 - Consume as few IP addresses as possible

# Solution
Starting from private IP addresses, `host-1-a` has been set to contain up to 130 hosts, thus those IP addresses must be `/24` because 130 becomes 10000010 (8 bits) when converted in binary.
By following the same principle, `host-1-b` must be `/27` because it must contain 25 hosts.

In both `router-1` and `router-2` all interfaces has to be set up and are assigned a different IP address.
As you can notice, in `router-2` the default router has been deleted and replaced with the relative IP address of `router-1` to which it is connected.
I did not replaced `router-1` default router with the IP address of `router-2` in order to avoid loops: if a host requests access to an IP address which is neither reachable by `router-1` nor by `router-2`, the packet will keep brouncing from one router to the other untill the TTL - time to live - expires.

To test the reachability of the web server (on `host-2-c`) do command *curl 172.23.1.34:8080* on `host-1-a` or `host-1-b` and expect the following result
```

<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.15.8</center>
</body>
</html>

```

Why this?
As you might have noticed, during the setting up of `host-2-c`, an error has incurred: _host-2-c: Unable to find image 'nginx:latest' locally_
Fortunately the system is smart enough to correct it by itself, infact on the next line we find _host-2-c: latest: Pulling from library/nginx_ then the pulling and dowloading request for a newer image for nginx:latest are completed.


# Commands meaning

Given the scripts by the professor, I adapted the code creating other scripts to be launched in their turn

| Commands                                           | Meaning                                                                                                                                                                                                                |
|:--------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| *ip link add link ethN name ethN.M type vlan id M* | Add a link into an existing interface _ethN_ and it is defined to be a VLAN link with and id _M_, where _N_ and _M_ are integers
| *ip link set dev ethN.M up*                        | Set an interface called _ethN.M_ up, where _N_ and _M_ are integers (_M_ is set only when many networks have to be set through the same interface _ethN_ ). By giving this command, that interface is ready to be used |
| *ip addr add 172.23.0.2/24 dev eth1*               | Add an address (specifying the subnet mask) to the interface called _eth1_                                                                                                                                             |
| *ip route del default*                             | Delete the default IP router address                                                                                                                                                                                   |
| *ip route add default via 172.23.1.37*             | After having been deleted, the default router is set to be a certain IP address                                                                                                                                        |
| *ip route add 172.23.1.32/30 via 172.23.1.38*      | It is also possible to add an IP network address which has to be reached through a certain interface                                                                                                                   |
| *ovs-vsctl add-br Name*                            | Set the machine to be a switch called _Name_                                                                                                                                                                           |
| *ovs-vsctl add-port Name ethN tag=M*               | Into the switch called _Name_ a port _ethN_ is added and (if there are vlans) the corresponding tag _M_, previously set on the router, must be used                                                                    |
| *curl 172.23.1.34:8080*                            | Using the port number 8080, the host (which can be either `host-1-a` or `host-1-b`) tries to reach a webpage hosted at address 172.23.1.34                                                                             |


```

