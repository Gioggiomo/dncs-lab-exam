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
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router-1`
`vagrant ssh router-2`
`vagrant ssh switch`
`vagrant ssh host-1-a`
`vagrant ssh host-1-b`
`vagrant ssh host-2-c`

# Description
To complete this assignment, we were asked to design a functioning network where any host configured and attached to router-1 (through switch) can browse a website hosted on host-2-c.
The requirements we were asked to respect are the following:
 - Up to 130 hosts in the same subnet of host-1-a
 - Up to 25 hosts in the same subnet of host-1-b
 - Consume as few IP addresses as possible

# Solution
Starting from private ip addresses, `host-1-a` has been set to contain up to 130 hosts thus, those ip addresses must be `/24` because 130 becomes 10000010 (8 bits) when converted in binary.
By following the same principle, `host-1-b` must be `/27` because it must contain 25 hosts.

...

