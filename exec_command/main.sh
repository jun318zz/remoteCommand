#!/bin/bash

COMMAND_FILE='command'


# Checked ip list file
TARGET_FILE=$1
TARGET_DIR=$(dirname $TARGET_FILE)
. ../make_live_ip/split.sh $TARGET_FILE


RESULT_DIR="z_result_`date +%Y_%m_%d_%H%M%S`"
mkdir $RESULT_DIR


# Connect server and exec command
for xfile in $(ls $TARGET_DIR/x*); do
    . exec.sh $xfile $RESULT_DIR $COMMAND_FILE &
done


while true; do
  num=$(ls $TARGET_DIR/x* | wc -l | egrep -o '\d+')
  num2=$(cat $RESULT_DIR/status.txt | wc -l | egrep -o '[0-9]+')

  echo "[Progress] Total: $num Done: $num2 "
  sleep 0.5

  if [ "$num" == "$num2" ];then
    echo "+-------------+"
    echo "|  COMPLETE!  |"
    echo "+-------------+"
    exit
  fi
done
