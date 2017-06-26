#!/bin/bash

XFILE=$1
RESULT_DIR=$2
COMMAND_FILE=$3


RESULT_FILE="$RESULT_DIR/result.csv"
GLOBAL_STATUS_FILE="$RESULT_DIR/status.txt"


for ip in $(cat $XFILE)
do
    ERROR_FILE="$RESULT_DIR/${ip}_error.txt"

    # Connect server and exec command
    #command_result=$(ssh $ip `cat $COMMAND_FILE` 2>> $ERROR_FILE)

    # For sample ip test
    command_result=$(sh $COMMAND_FILE 2>> $ERROR_FILE)

    # Write result to csv format file
    echo "$ip""$command_result" >> $RESULT_FILE
done

echo "done" >> $GLOBAL_STATUS_FILE
