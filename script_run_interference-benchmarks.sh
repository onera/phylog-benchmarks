#!/bin/bash
# $1 = name of the multi-core processor to test

function usage () 
{
    echo "Usage: $0 PROCESSOR"
    echo "Run all PHYLOG micro-benchmarks in isolation for the specified PROCESSOR."
    echo "All results stored under the Results/PROCESSOR folder."
}

if [ "$#" -lt 1 ] ; then
    usage
    echo "*** Error: No processor specified"
    exit 1
fi

if [ "$#" -ge 2 ] ; then
    usage
    echo "*** Error: Multiple processors specified"
    exit 1
fi

BENCHMARKS=$(pwd)
CODE=$BENCHMARKS/benchmarks

SCRIPT_DIR=${BENCHMARKS}/scripts
source $SCRIPT_DIR/var_generique.sh

RESULT="Results/$1"

if [ -d "$RESULT" ]; then
    cd $CODE
    RESULT="../$RESULT"
    for var in `ls`
    do
        if [ -d $var ]; then
	    cd $var

	    if [ -f script_execute_$var.sh ]; then
		./script_execute_$var.sh "../$RESULT"
	    else
		if [ -f script_execute.sh ]; then
		./script_execute.sh $var "../$RESULT" 
		fi
	    fi
	    cd ..
	fi
    done
else
    echo "*** Error: Processor $1 is not known in directory Results"
fi
