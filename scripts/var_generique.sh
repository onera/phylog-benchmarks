# $1 = processor to be tested
#!/bin/bash

RESULT=$BENCHMARKS/Results/$1

if [ ! -d $RESULT ]; then
    echo "*** Error: Processor $1 unknown in Results"
    exit 0
fi

host=`hostname`
nb_core=0

if [ $host = "TimeBerry" ] ||  [ $host = "ls1043ardb" ] ||  [ $host = "imx8" ] ||  [ $host = "imx8mpevk" ]; then
    nb_core=4
fi
if [ $host = "j7200-evm" ] ||  [ $host = "am64xx-evm" ]; then
    nb_core=2
fi
