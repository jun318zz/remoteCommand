#!/bin/bash 

# Check method: ping, 22_port
CHECK_METHOD="ping"


TARGET_FILE=$1
TARGET_DIR=$(dirname $TARGET_FILE)


. init.sh $TARGET_DIR $CHECK_METHOD
. split.sh $TARGET_FILE


# Check target ip
for xfile in $(ls $TARGET_DIR/x*); do
    . check.sh $xfile $TARGET_DIR $CHECK_METHOD &
done


while true; do
  num=$(cat $TARGET_DIR/info.txt)
  num2=$(cat checked_$TARGET_DIR/$CHECK_METHOD/*ip | wc -l | egrep -o '[0-9]+')

  echo "[Progress] Total: $num Done: $num2 "
  sleep 0.5

  if [ "$num" == "$num2" ];then
    echo "+-------------+"
    echo "|  COMPLETE!  |"
    echo "+-------------+"
    exit
  fi
done
