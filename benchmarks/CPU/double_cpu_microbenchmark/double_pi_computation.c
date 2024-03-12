// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"
#include "get_counters.h"

void double_pi_computation (int iter, int mode) 
{ 
    register double pi = 0.0;
    register int i;
    register int N = PI_COMPUTATION_DEPTH;

    assert(N % 2 == 0);
 
    // start of measurement section
    // ----------------------------------
    counters_record start = get_counters_start();

    for (i = 0; i < N ; i++) {
        pi +=  1.0 * 4.0 / (2.0 * i++ + 1);
        pi += -1.0 * 4.0 / (2.0 * i + 1); 
    }
    pi += 1.0 * 4.0 / (2.0 * i++ + 1);

    counters_record end = get_counters_stop(); 
    // ----------------------------------
    // end of measurement section

    if (mode != AGGRESSOR) print_counters(iter, start, end);
}
