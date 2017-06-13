#!/bin/bash

TARGET_FILE=$1
TARGET_DIR=$(dirname $TARGET_FILE)


# Remove old data
rm -f $TARGET_DIR/x*


# Split into several files
split -a 3 -l 10 $TARGET_FILE


# Update splited files and info
mv x* $TARGET_DIR
echo $(cat $TARGET_FILE | wc -l | egrep -o '[0-9]+') > $TARGET_DIR/info.txt
