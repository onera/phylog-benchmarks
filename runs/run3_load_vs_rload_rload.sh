# $1 = proc testé (raspberryPi1, raspberryPi4)
# $2 = parametre de l'agresseur (null si pas de parametre)
# $3 = parametre de l'agresseur (null si pas de parametre)
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par3_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 3 ]; then
    FUNCTION=deterministic_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=random_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    AGGRESSOR2=random_index_chasing_load_microbenchmark
    AGGRESSOR2WORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3"
    exec_par3_generique $2 $3
    
    FUNCTION=random_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=random_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    AGGRESSOR2=random_index_chasing_load_microbenchmark
    AGGRESSOR2WORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3"
    exec_par3_generique $2 $3

fi
