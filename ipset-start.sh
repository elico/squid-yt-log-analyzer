#!/usr/bin/env bash

DNSIP="192.168.10.254"
SCRIPTSPATH="."
LOGFILE="/tmp/a1.log"

ipset flush slowpool

ipset create slowpool hash:ip
$SCRIPTSPATH/log-parser.rb $LOGFILE $DNSIP | xargs -l1 -n1 ipset add slowpool


