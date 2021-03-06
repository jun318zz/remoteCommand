#!/bin/bash

RESULT_DIR="z_result_`date +%Y_%m_%d_%H%M%S`"
mkdir $RESULT_DIR


# Checked ip list file
TARGET_FILE=$1
TARGET_DIR=$(dirname $TARGET_FILE)
. ../make_live_ip/split.sh $TARGET_FILE


# Make real exec command
COMMAND_FILE='command'
for command in $(cat $COMMAND_FILE); do
	echo "printf \",\$($command)\";" >> ${COMMAND_FILE}_real
done


# Connect server and exec command
for xfile in $(ls $TARGET_DIR/x*); do
    . exec.sh $xfile $RESULT_DIR ${COMMAND_FILE}_real &
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
    rm -f ${COMMAND_FILE}_real
    exit
  fi
done
