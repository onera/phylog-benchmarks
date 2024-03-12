// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"
#include "get_counters.h"


void store_with_add_stride (long * tab, int lg, int stride, int mode)
{
    register long a = 1 ;
    register long * pti = tab ; 
    register int stride_reg = stride;
    register int lg_reg = lg;
    register long * tab_reg = tab;

    // start of measurement section
    // ----------------------------------
    counters_record start = get_counters_start();

    for ( register int k = 0; k < stride_reg ; k++) {
        pti = tab_reg + k; 
	for ( register  int l = k ; l < lg_reg  ; l += stride_reg , pti += stride_reg ) {
	  *pti = a  ;
        }
    }
    
    counters_record end = get_counters_stop(); 
    // ----------------------------------
    // end of measurement section
    
    if (mode != AGGRESSOR) print_counters(stride, start, end);

}
