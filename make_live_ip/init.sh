#!/bin/bash 

DIR=$1
CHECK_METHOD=$2
CHECK_DIR="checked_$DIR/$CHECK_METHOD"

if [ -d "$CHECK_DIR" ]; then
  rm -rf "$CHECK_DIR"/*
else
  mkdir -p "$CHECK_DIR"
fi
