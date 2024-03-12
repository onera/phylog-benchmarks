#!/bin/bash

BENCHMARKS=$(pwd)

INCLUDE=${BENCHMARKS}/include
CODE=${BENCHMARKS}/benchmarks

cd $CODE

for var in `ls`
do
        if [ -d $var ]; then
	    cd $var

	    if [ -f script_compile_$var.sh ]; then
		./script_compile_$var.sh $INCLUDE
	    else
		if [ -f script_compile.sh ]; then
		./script_compile.sh $INCLUDE $var
		fi
	    fi
	    cd ..
	fi
done





