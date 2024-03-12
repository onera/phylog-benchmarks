# $1 = proc testé (raspberryPi1, raspberryPi4)
#!/bin/bash

BENCHMARKS=$(pwd)
SCRIPT_DIR=${BENCHMARKS}/scripts

source $SCRIPT_DIR/var_generique.sh
source $SCRIPT_DIR/exec_par3_generique.sh
source $SCRIPT_DIR/bench_path.sh

if [ $nb_core -ge 3 ]; then
    FUNCTION=float_cpu_microbenchmark
    BENCHWORKINGSPACE=${float_cpu_microbenchmark_path}
    AGGRESSOR1=float_cpu_microbenchmark
    AGGRESSOR1WORKINGSPACE=${float_cpu_microbenchmark_path}
    AGGRESSOR2=float_cpu_microbenchmark
    AGGRESSOR2WORKINGSPACE=${float_cpu_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3"
    exec_par3_generique 0 0

    FUNCTION=long_cpu_microbenchmark
    BENCHWORKINGSPACE=${long_cpu_microbenchmark_path}
    AGGRESSOR1=float_cpu_microbenchmark
    AGGRESSOR1WORKINGSPACE=${float_cpu_microbenchmark_path}
    AGGRESSOR2=float_cpu_microbenchmark
    AGGRESSOR2WORKINGSPACE=${float_cpu_microbenchmark_path}
    echo "$FUNCTION + $AGGRESSOR1 $2 + $AGGRESSOR2 $3"
    exec_par3_generique 0 0

fi





