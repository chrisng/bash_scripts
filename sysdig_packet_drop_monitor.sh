#!/bin/bash
set -eu

# ----------------------------
# Script used to use sysdig & to capture some packet loss
# Cron to run: 
# */15 * * * * <path to script>check_packet_drop.sh 2>&1 <path to some logdir>/check_packet.out

DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BASE_DIR=$(dirname $0)

hash sysdig 2> /dev/null || { echo "Cannot find sysdig";exit 1 }


ifconfig eth1 |grep dropped |sed -e "s/^/$DATE/g" -e "s/:/ /g" >> ${BASE_DIR}/packet_drop.log 2>&1

sysdig -s 4096 -z -w ${BASE+DIR}/sysdig_${DATE}.scap.gz &
SYSDIGPID=$!
sleep 60

# Extra kill commands
killall -SIGINT sysdig
PID_COUNT=$(ps -ef |grep -v $SYSDIGPID | grep -c $SYSDIGPID)
if [ $PID_COUNT -gt 0 ] ; then
  killall sysdig
fi
