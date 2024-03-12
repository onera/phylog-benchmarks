// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"
#include "get_counters.h"


void int_prime_number_factorization (int iter, int mode) 
{
    register int X = VALUE_TO_FACTORIZE ;
    
    register int i ;
    register int j ;
    register int val = 1; 
    register int old = 0;

    // start of measurement section
    // ----------------------------------
    counters_record start = get_counters_start();
    
    for (i = 2; i< X/2; i++)
        for (j = 2 ; j <= X/2 ; j++ )
            if (X  == i*j) {
                val *= i ; old = j ;
                X = j; i = 1 ; j = 1 ; 
            }

    counters_record end = get_counters_stop(); 
    // ----------------------------------
    // end of measurement section

    if (mode != AGGRESSOR) print_counters(iter, start, end);


    assert ( val*old == VALUE_TO_FACTORIZE ); 
}
