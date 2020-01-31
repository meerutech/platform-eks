#!/bin/bash -x
if [ -f "config.ini" ]; then
	eval "$(cat config.ini | ./ini2arr.py)"
else
	echo "config.ini missing!"
	#exit 1
fi
