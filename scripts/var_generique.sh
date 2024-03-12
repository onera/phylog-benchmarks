# $1 = processor to be tested
#!/bin/bash

if [ "$#" -lt 1 ] ; then
    echo "*** Error: No processor specified"
    exit 1
fi

RESULT="$BENCHMARKS/Results/$1"

if [ ! -d "$RESULT" ]; then
    read -p "Create the missing result directory '$RESULT' (y/n)? " -n 1 -r CREATE_RESULT
    echo    
    if [[ $CREATE_RESULT =~ ^[Yy]$ ]]
    then
        mkdir -p "$RESULT"
    fi
fi

if [ ! -d "$RESULT" ]; then
    echo "*** Error: Unknown Processor '$1' in Results directory"
    exit 0
fi

host=`hostname`
nb_core=0

if [ $host = "TimeBerry" ] ||  [ $host = "ls1043ardb" ] ||  [ $host = "imx8" ] ||  [ $host = "imx8mpevk" ] || [ $host = "WDTIS2200H" ] ; then
    nb_core=4
fi
if [ $host = "j7200-evm" ] ||  [ $host = "am64xx-evm" ]; then
    nb_core=2
fi

if [ "$#" -lt 1 ] ; then
    echo "*** Error: Unknown number of cores for host '$host'"
    exit 1
fi 
