#!/bin/bash

function exec_par3_generique(){
# param: $1 = parametre de l'agresseur 1
# param: $2 = parametre de l'agresseur 2
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
    
    # echo "--> cd $AGGRESSOR2WORKINGSPACE"
    if [ ! -d $AGGRESSOR2WORKINGSPACE ]; then
	echo "*** Error: $AGGRESSOR2WORKINGSPACE not found"
	cd $BENCHMARKS
	exit 0
    fi
    cd $AGGRESSOR2WORKINGSPACE

    if [ ! -f aggressor_${AGGRESSOR2} ]; then
	echo "*** Error: aggressor_${AGGRESSOR2} not found"
	cd $BENCHMARKS
	exit 0
    fi
    cp aggressor_${AGGRESSOR2} ${AGGRESSOR2}_agresseur2
    # echo "--> exec: aggressor2 $2 &"
    taskset -c 2 ./${AGGRESSOR2}_agresseur2 $2 &
    pid_agresseur2=$!
    
    cd $BENCHWORKINGSPACE
    # echo "--> exec: victim ($FUNCTION) + aggressor ($AGGRESSOR1) > $RESULT/${FUNCTION}_${AGGRESSOR1}_$1_${AGGRESSOR2}_$2.txt"
    taskset -c 0 ./victim_${FUNCTION} > "$RESULT/${FUNCTION}_${AGGRESSOR1}_$1_${AGGRESSOR2}_$2.txt"

    kill $pid_agresseur1
    kill $pid_agresseur2
    cd $AGGRESSOR1WORKINGSPACE
    rm -f ${AGGRESSOR1}_agresseur1 
    cd $AGGRESSOR2WORKINGSPACE
    rm -f ${AGGRESSOR2}_agresseur2 
    # echo "--> cd $BENCHMARKS"
    cd $BENCHMARKS
}

