#!/bin/bash
# $1 = proc testé (raspberryPi1, raspberryPi4)

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par2_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 2 ]; then
    source $SCRIPT_DIR/exec_par2_generique.sh

    FUNCTION=float_cpu_microbenchmark
    BENCHWORKINGSPACE=${float_cpu_microbenchmark_path}
    AGGRESSOR1=float_cpu_microbenchmark
    AGGRESSOR1WORKINGSPACE=${float_cpu_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique 0

    FUNCTION=long_cpu_microbenchmark
    BENCHWORKINGSPACE=${long_cpu_microbenchmark_path}
    AGGRESSOR1=float_cpu_microbenchmark
    AGGRESSOR1WORKINGSPACE=${float_cpu_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2"
    exec_par2_generique 0
fi




