#!/bin/bash
# $1 = RESULT

RESULT=$1

for var in `ls`
do
        if [ -d $var ]; then
	    cd $var

	    if [ -f script_execute_$var.sh ]; then
		./script_execute_$var.sh ../$RESULT
	    else
		if [ -f script_execute.sh ]; then
		./script_execute.sh $var ../$RESULT 
		fi
	    fi
	    cd ..
	fi
done

