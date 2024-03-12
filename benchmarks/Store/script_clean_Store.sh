#!/bin/bash

for var in `ls`
do
        if [ -d $var ]; then
	    cd $var

	    if [ -f script_clean_$var.sh ]; then
		./script_clean_$var.sh
	    else
		if [ -f script_clean.sh ]; then
		./script_clean.sh $var
		fi
	    fi
	    cd ..
	fi
done

