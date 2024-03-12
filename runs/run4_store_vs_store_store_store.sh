# $1 = proc testé (raspberryPi3)
# $2 = parametre de l'agresseur1
# $3 = parametre de l'agresseur2
# $4 = parametre de l'agresseur2
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par4_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 4 ]; then
    FUNCTION=add_store_microbenchmark
    BENCHWORKINGSPACE=${add_store_microbenchmark_path}
    AGGRESSOR1=add_store_microbenchmark
    AGGRESSOR1WORKINGSPACE=${add_store_microbenchmark_path}
    AGGRESSOR2=add_store_microbenchmark
    AGGRESSOR2WORKINGSPACE=${add_store_microbenchmark_path}
    AGGRESSOR3=add_store_microbenchmark
    AGGRESSOR3WORKINGSPACE=${add_store_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3 + $AGGRESSOR3 $4"
    exec_par4_generique $2 $3 $4

fi
