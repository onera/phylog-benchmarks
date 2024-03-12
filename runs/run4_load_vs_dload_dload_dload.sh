# $1 = proc testé (raspberryPi1, raspberryPi4)
# $2 = parametre de l'agresseur1 (null si pas de parametre)
# $3 = parametre de l'agresseur2 (null si pas de parametre)
# $4 = parametre de l'agresseur3 (null si pas de parametre)
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par4_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 4 ]; then
    FUNCTION=deterministic_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR2=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR2WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR3=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR3WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3 + $AGGRESSOR3 $4"
    exec_par4_generique $2 $3 $4
    
    FUNCTION=random_index_chasing_load_microbenchmark
    BENCHWORKINGSPACE=${random_index_chasing_load_microbenchmark_path}
    AGGRESSOR1=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR2=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR2WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    AGGRESSOR3=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR3WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3 + $AGGRESSOR3 $4"
    exec_par4_generique $2 $3 $4

fi
    




