#!/bin/bash
# $1 = Bench to be compiled
# $2 = RESULT

FUNCTION=$1
RESULT=$2

echo $FUNCTION

if [ -f victim_$FUNCTION ]; then
    ./victim_$FUNCTION > $RESULT/victim_$FUNCTION.txt
else
    echo "*** Error victim_$FUNCTION not found"
fi

exit 0
