# $1 = proc testé (raspberryPi3)
# $2 = parametre de l'agresseur
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par2_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 2 ]; then
    FUNCTION=deterministic_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=add_store_microbenchmark
    AGGRESSOR1WORKINGSPACE=${add_store_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique $2

    FUNCTION=random_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=add_store_microbenchmark
    AGGRESSOR1WORKINGSPACE=${add_store_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique $2

fi
