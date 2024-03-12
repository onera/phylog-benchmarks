#!/bin/bash
# $1 = INCLUDE
# $2 = Bench to be compiled

INCLUDE=$1

COMPILER=gcc
FLAG="-Wall -std=c99 -pedantic -O0 -o"
FUNCTION=$2

echo $FUNCTION

if [ -f aggressor_${FUNCTION}.c ]; then
    if [ ! -f aggressor_${FUNCTION} ]; then
	$COMPILER -I$INCLUDE $FLAG  aggressor_${FUNCTION}  aggressor_${FUNCTION}.c load_with_index_chasing.c
    else
	true
    fi
fi

if [ ! -f $FUNCTION ]; then
    $COMPILER -I$INCLUDE $FLAG victim_$FUNCTION victim_$FUNCTION.c load_with_index_chasing.c
else
    true
fi

exit 0
