#!/usr/bin/env bash

# http://tldp.org/HOWTO/Linux+IPv6-HOWTO/x2761.html

set -x
# Lan interface
LAN="lan1"
DEFAULTCLASS="1:5"

tc qdisc delete dev $LAN root handle 1: cbq avpkt 1000 bandwidth 1000Mbit

tc qdisc add dev $LAN root handle 1: cbq avpkt 1000 bandwidth 1000Mbit

tc class add dev $LAN parent 1: classid 1:1 cbq rate  50Mbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:2 cbq rate  20Mbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:3 cbq rate  10Mbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:4 cbq rate  5Mbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:5 cbq rate  2Mbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:6 cbq rate  1Mbit allot 1500 bounded

tc class add dev $LAN parent 1: classid 1:14 cbq rate  500kbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:15 cbq rate  200kbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:16 cbq rate  100kbit allot 1500 bounded
tc class add dev $LAN parent 1: classid 1:17 cbq rate  50kbit allot 1500 bounded

#tc filter add dev $LAN parent 1: protocol ipv4 handle 32 fw flowid 1:4
#tc filter add dev $LAN parent 1: protocol ipv4 handle 31 fw flowid 1:14
#tc filter add dev $LAN parent 1: protocol ipv4 handle 32 fw flowid 1:17


ipset flush slowpool

ipset create slowpool hash:ip

iptables -t mangle -I FORWARD -m set --match-set slowpool dst,src -j CLASSIFY --set-class $DEFAULTCLASS

set +x

