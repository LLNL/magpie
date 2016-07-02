#!/bin/bash

seconds=3600

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
	-s)
	    seconds=$2
	    shift
	    ;;
	*)
            echo "Usage: test-sleep [-s seconds]"
	    exit 1
	    ;;
    esac
    shift
done

sleep ${seconds}
