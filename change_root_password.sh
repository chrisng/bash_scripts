#!/bin/bash

set -u

read -p "What is your password? " MYPASS
read -p "What do you want to change root password to ?" ROOTPASS

if [ -z $MYPASS ] ; then
  echo "YOU DO NOT HAVE $MYPASS variable set"
  exit 5
else
  for HOST in `cat servers`; do

    sshpass -e scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no /usr/bin/sshpass $HOST:/tmp
    echo $MYPASS |sshpass -e ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $HOST "sudo -S bash -c \"echo root:$ROOTPASS | /usr/sbin/chpasswd | echo $? \"" 2>&1 | tee --append /tmp/my.log

  done

fi
