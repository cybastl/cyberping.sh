Cyberping - a little ping helper


This script pings a host for X times with a delay of Y seconds
  If no packetloss ocurred it increases a counter by one
  If packetloss occurs it prints the time and resets the counter
Every Z counters it prints the current time
Hostname, X, Y and Z are configurable via commalindline
e.g. cyberping.sh google.com 5 0.2 50 (which is actually are the defaults)
 

Tested on Linux and on Android running Termux.
