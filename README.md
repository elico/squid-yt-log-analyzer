Rate limiting per src or dst IP addresses on a Linux Router
=====

Don't use this technique without any solid and specific reason!
-----
With any tool comes some risk in understanding what is right and what is wrong.
When handling rate limiting traffic you need to be carefull!!
I know from expirence that sometime the breaking point of a person\client\human can be the option to watch a tiny video clip.
Many families understand that at night it's not always recommended to walk in the steets.
Due to this the Computer and the Television are tools that helps to either learn or ease your mind from specific things in life.
It is known that there is a possibility in life to get addicted to good things as much as for bad and messing around with clients minds doesn't end well in most cases.
Limiting your clients bandwidth is a tool that comes to answer an issue and should not be used as a "default" solution in any environment.
In very specific environments it's commonly used to enforce policy since the bandwidth is required for more important uses such as life support navigation systems.


The Idea
-----
Video streams sometimes slow down other more important traffic on a network.
To mitigate the effect of such situations we can(carefully) slow down some traffic.
Squid-Cache logs can be parsed to extract host names and to target specific ip addresses to be "limited" or more acurate be "bounded".

Requirments
-----
- A Linux router
- iptables support installed
- IPSET installed
- Ruby(or write a similar with your own favorite language)
- Squid-Cache
- DNS server(either public or private)

Usage
-----
- Boot the Router box with all the default iptables rules.
- Change the qos-start.sh script to reflect your lan\internal network interface to apply the rules on.
- Change the qos-start.sh script DEFAULTCLASS to match the tc class to match the "bounding" speed limit rule for all video traffic. For example if you want to limit all your clients to a slice of 20Mbit then use class "1:2". This limit is to all of the clients together and a set of clients or IP addresses will be bounded to this limit. To make exceptions for the policy you will need to place an iptables ACCEPT rule for a specific client or server ip on the top of the iptables rules, before classifiction happen.
- run the qos-start.sh script that will create the IPSET "Bucket"
- Change the ipset-refresh.sh DNSIP, SCRIPTSPATH and LOGFILE variables to reflect your environment.
- run the ipset-refresh.sh as a crontab every once in a while to fill the IPSET "Bucket" with the relevant IP addresses of the annoying targeted domains. The script runs in an "incrementing" state which means that old enteries will not be removed from the IPSET "Bucket". If you need to clean it up everytime use the ipset-start.sh script instead.

This script was used by me more then once but you need first to understand what are the effects and who is affected by this action!!!
You should consider other options before using this script!!
