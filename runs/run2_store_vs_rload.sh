# $1 = proc testé (raspberryPi3)
# $2 = parametre de l'agresseur
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par2_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 2 ]; then
    FUNCTION=add_store_microbenchmark
    BENCHWORKINGSPACE=${add_store_microbenchmark_path}
    AGGRESSOR1=random_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique $2

fi
