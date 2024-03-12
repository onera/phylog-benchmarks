#!/bin/bash

function exec_par2_generique(){
# param: $1 = parametre de l'agresseur
    # echo "--> cd $BENCHWORKINGSPACE"
    if [ ! -d $BENCHWORKINGSPACE ]; then
	echo "*** Error: $BENCHWORKINGSPACE not found"
	cd $BENCHMARKS
	exit 0
    fi
    cd $BENCHWORKINGSPACE

    if [ ! -f victim_$FUNCTION ]; then
	echo "*** Error: victim_${FUNCTION} not found"
	cd $BENCHMARKS
	exit 0
    fi

    # echo "--> cd $AGGRESSOR1WORKINGSPACE"
    if [ ! -d $AGGRESSOR1WORKINGSPACE ]; then
	echo "*** Error: $AGGRESSOR1WORKINGSPACE not found"
	cd $BENCHMARKS
	exit 0
    fi
    cd $AGGRESSOR1WORKINGSPACE

    if [ ! -f aggressor_${AGGRESSOR1} ]; then
	echo "*** Error: aggressor_${AGGRESSOR1} not found"
	cd $BENCHMARKS
	exit 0
    fi
    cp aggressor_${AGGRESSOR1} ${AGGRESSOR1}_agresseur1
    # echo "--> exec: aggressor1 $1 &"
    taskset -c 1 ./${AGGRESSOR1}_agresseur1 $1 &
    pid_agresseur1=$!
    
    cd $BENCHWORKINGSPACE
    # echo "--> exec: victim ($FUNCTION) + aggressor ($AGGRESSOR1) > $RESULT/${FUNCTION}_${AGGRESSOR1}_$1.txt"
    taskset -c 0 ./victim_${FUNCTION} > $RESULT/${FUNCTION}_${AGGRESSOR1}_$1.txt

    kill $pid_agresseur1
    cd $AGGRESSOR1WORKINGSPACE
    rm -f ${AGGRESSOR1}_agresseur1 
    # echo "--> cd $BENCHMARKS"
    cd $BENCHMARKS
}

