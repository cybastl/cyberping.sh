#
# cyberping - a little ping helper
#
# MIT License
#
# Copyright (c) 2018 cybastl@gmx.de
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#
# This script pings a host for X times with a delay of Y seconds
#   If no packetloss ocurred it increases a counter by one
#   If packetloss occurs it prints the time and resets the counter
# Every Z counters it prints the current time
# Hostname, X, Y and Z are configurable via commalindline
# e.g. cyberping.sh google.com 5 0.2 50 (which is actually are the defaults)
# 

let "lost=0"
let "total=0"
let "succ=0"
ping_host=${1:-"google.com"}
ping_count=${2:-"5"}
ping_freq=${3:-"0.2"}
ping_cons=${4:-"50"}
#dateformat="+%H:%M:%S:%N"
dateformat="+%T.%3N"
echo "`date $dateformat`: pinging $ping_host for $ping_count times, with freq=$ping_freq, collecting $ping_cons results"

while true; do
pingstatus="`ping -c $ping_count -i $ping_freq $ping_host`"
pingcode=$?
loss=`echo $pingstatus | grep loss | rev | cut -d ',' -f 2 | rev`
if [ $pingcode -ne 0 ]; then
        echo -e "\n`date $dateformat`: $loss"
        let "succ=0"
        let "lost++"
else
        let "total++"
        let "succ++"
        echo -ne "succ: $succ \tlost: $lost\t total: $total\r"
        if [ $(( $succ % $ping_cons )) -eq 0 ]; then
                echo -e "\n`date $dateformat`"
        fi
fi

done

