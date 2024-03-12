// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"


// ----------------------------------------
// Aggressor version of the double precision CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
    while (1) { 
      double_pi_computation (0, AGGRESSOR) ;
    } 
    return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_double_cpu_microbenchmark aggressor_double_cpu_microbenchmark.c double_pi_computation.c 
