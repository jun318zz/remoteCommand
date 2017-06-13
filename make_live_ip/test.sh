#!/bin/bash

function test() {

	ping -c 1 -t 1 127.0.0.2 > /dev/null 2>&1
	echo $?
	#return $?
}
i=10
result=$(test $i)
#test $i
echo $?
echo "result: $result"
exit
a="ls"

eval $a

if [ $a == "ping" ]; then
	echo 'ping'
fi

: '
for i in $(ls); do
	echo $i
done
'
#
