#!/bin/bash

# shoud be used sudo 
#
# Eth1's IP is 192.168.100.1

sysctl -w net.ipv4.ip_forward=1
/sbin/iptables -t nat -A POSTROUTING -s 192.168.2.0/255.255.255.0 -j MASQUERADE

# type following eth1 network machine
# /sbin/route add default gw 192.168.100.1
# echo "nameserver 192.168.0.1" > /etc/resolv.conf
