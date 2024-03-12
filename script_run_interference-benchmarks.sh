#!/bin/bash
# $1 = name of the multi-core processor to test

BENCHMARKS=$(pwd)
CODE=$BENCHMARKS/benchmarks

SCRIPT_DIR=${BENCHMARKS}/scripts
source $SCRIPT_DIR/var_generique.sh

RESULT=Results/$1

if [ -d $RESULT ]; then
    cd $CODE
    RESULT=../$RESULT
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
else
    echo "*** Error: Processor $1 is not known in directory Resuts"
fi
