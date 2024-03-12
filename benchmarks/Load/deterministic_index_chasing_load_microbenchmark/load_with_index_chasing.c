// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"
#include "get_counters.h" 


void load_with_index_chasing (long *tab, int lg, int stride, int mode)
{
    register int pti = 0;
    register int lg_reg = lg ;
    
    // start of measurement section
    // ----------------------------------
    counters_record start = get_counters_start();

    for (register int j=0 ; j < lg_reg; j=j+1)  {
      pti = tab[pti]; 
    }

    counters_record end = get_counters_stop(); 
    // ----------------------------------
    // end of measurement section

    if ( mode != AGGRESSOR) print_counters(stride, start, end);

}
