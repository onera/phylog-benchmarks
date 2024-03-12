# $1 = proc testé (raspberryPi3)
# $2 = parametre de l'agresseur
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par3_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 3 ]; then
    FUNCTION=add_store_microbenchmark
    BENCHWORKINGSPACE=${add_store_microbenchmark_path}
    AGGRESSOR1=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR2=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR2WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3"
    exec_par3_generique $2 $3

fi
