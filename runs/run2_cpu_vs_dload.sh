# $1 = proc testé (raspberryPi1, raspberryPi4)
# $2 = parametre de l'agresseur (null si pas de parametre)
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par2_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 2 ]; then
    FUNCTION=float_cpu_microbenchmark
    BENCHWORKINGSPACE=${float_cpu_microbenchmark_path}
    AGGRESSOR1=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique $2
        
    FUNCTION=long_cpu_microbenchmark
    BENCHWORKINGSPACE=${long_cpu_microbenchmark_path}
    AGGRESSOR1=deterministic_index_chasing_load_microbenchmark
    AGGRESSOR1WORKINGSPACE=${deterministic_index_chasing_load_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique $2
fi





