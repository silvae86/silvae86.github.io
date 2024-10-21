---
layout: post
title:  "Tethering internet from iPhone to a Ubuntu machine and then to a wifi router via ethernet"
date: 2024-10-20 23:15:000 +0100
tags: ["iphone", "internet", "tethering", "ubuntu", "tp-link", "AX1500", "wifi-6","WR1502X" ,"travel","router"]
published: true
comments_id: 58
---

{% include image.html src="/assets/images/post-images/2024-10-21-connect-iphone-to-ubuntu-machine-tether-ethernet/setup.jpg"
caption="Picture of the setup" imageposition="center"
title="Picture of the setup"
%}

Travelling with an iPhone as a hotspot is good enough in a pinch, but the signal is weak and will cause disconnections if used as the main Access Point in a home.

This post explains how to connect an iPhone to a Ubuntu machine via usb and then share the internet connection to a wifi router via the ethernet port of that machine.

{% include image.html src="/assets/images/post-images/2024-10-21-connect-iphone-to-ubuntu-machine-tether-ethernet/network.png"
caption="iPhone + Ubuntu box + Router network" imageposition="center"
title="iPhone + Ubuntu box + Router network"
%}


I am using a [TP-Link WR1502X Travel Router](https://www.tp-link.com/in/home-networking/wifi-router/tl-wr1502x/). The router is supposed to have built-in USB tethering, but it did not work with my iPhone 15 Pro running iOS 17. An older iPhone SE 2020 with iOS 16 works, so it goes to show how reliable these USB tethering things are. Putting an [HP T630 Thin Client](https://support.hp.com/id-en/product/details/hp-t630-thin-client/10522151) to act as our Gateway via ethernet will fix this.

## Configuring the Linux PC

```bash
# see these values with `sudo lshw -class network -short`
IPHONE_NIC='enxd26b7855052c' # the iphone's Ethernet "virtual connection"
ETHERNET_NIC='enp1s0' # your network card where you'll connect the router via cable


# Enable IP Forwarding sysctl -w net.ipv4.ip_forward=1. This will enable the kernel to forward packets, which are arriving to this machine.
sudo sysctl -w net.ipv4.ip_forward=1

# Assign a static IP within the same mask as the router's DHCP pool, but that you will later assign as a reserved IP in the DHCP pool
sudo ifconfig $ETHERNET_NIC 192.168.0.253 netmask 255.255.255.0 up

# install persistent iptables to make the forwarding -> masquerading permanent
sudo apt install -y iptables-persistent
sudo systemctl enable netfilter-persistent.service
sudo systemctl status netfilter-persistent.service

# Enable masquerading on the interface which is connected to the internet. sudo iptables -t nat -A POSTROUTING -o $IPHONE_NIC -j MASQUERADE. This will masquerade (replace the src ip on the packet with the $IPHONE_NIC ip) all traffic arriving from other interfaces, to the $IPHONE_NIC interface.
sudo iptables -t nat -A POSTROUTING -o $IPHONE_NIC -j MASQUERADE

# Add iptable rules to ACCEPT and FORWARD traffic from the subnet
sudo iptables -I FORWARD -o $IPHONE_NIC -s 192.168.0.0/16 -j ACCEPT
sudo iptables -I INPUT -s 192.168.0.0/16 -j ACCEPT

# Make changes persistent across boots
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

# Router configuration

Router will be at [http://192.168.0.1](http://192.168.0.1) when you are connected to its Wifi network.

1. Put router in router mode (physical slider)
2. Put ethernet cable in LAN port and connect to linux host ethernet port
3. Network tab will show error, never mind that
4. Internet tab
 	- Type: Router (Current)
 	- Internet connection type -> Dynamic IP
 	- Use Default MAC address
5. Wifi configure how you want (SSID + PASS)
6. Advanced
 	- Internet Connection Type -> Click Renew lease
  	- LAN - IP Address -> 192.168.0.1
 
7. DHCP Server 
        - Enable
 	- IP Address pool - 192.168.0.2 - 192.168.0.100
 	- Default Gateway - 192.168.0.253 (Static IP in Linux Machine's ethernet port)
 	- Primary DNS: 8.8.8.8
 	- Secondary DNS: 8.8.4.4
 	- Address Reservation -> hotspot (linux machine)
 	        - MAC ADDRESS: Computer's Ethernet MAC address (use `ifconfig` to see it)
 	        - IP Address: 192.168.0.253


## References

[Sharing internet connection from a linux machine over Ethernet](https://medium.com/@TarunChinmai/sharing-internet-connection-from-a-linux-machine-over-ethernet-a5cbbd775a4f).


