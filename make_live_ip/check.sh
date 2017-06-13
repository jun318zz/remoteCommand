#!/bin/bash

XFILE=$1
DIR=$2
CHECK_METHOD=$3

ping_check(){
  ping -c 1 -t 1 $1 > /dev/null 2>&1
  echo $?
}
port_22_check(){
  nc -z -w 1 $1 22 > /dev/null 2>&1
  echo $?
}

for ip in $(cat $XFILE); do

  result=$( ${CHECK_METHOD}_check $ip )

  if [ $result -ne 0 ]; then
    echo $ip >> checked_${DIR}/${CHECK_METHOD}/dead_ip
  else
    echo $ip >> checked_${DIR}/${CHECK_METHOD}/live_ip
  fi
done
