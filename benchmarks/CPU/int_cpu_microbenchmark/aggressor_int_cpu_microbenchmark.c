// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"


// ----------------------------------------
// Aggressor version of the interger CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
    while (1) {
      int_prime_number_factorization (0, AGGRESSOR) ; 
    }
    return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_int_cpu_microbenchmark aggressor_int_cpu_microbenchmark.c int_prime_number_factorization.c 
