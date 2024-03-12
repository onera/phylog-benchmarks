// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"


// ----------------------------------------
// Aggressor version of the float CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
    while (1) {
      float_pi_computation (0, AGGRESSOR) ;
    }
    return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_float_cpu_microbenchmark aggressor_float_cpu_microbenchmark.c float_pi_computation.c 
