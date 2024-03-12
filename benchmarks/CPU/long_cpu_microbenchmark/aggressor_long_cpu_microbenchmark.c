// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"

// ----------------------------------------
// Aggressor version of the long-integer CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
    while (1) {
        long_prime_number_factorization (0, AGGRESSOR) ; 
    }  
    return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_long_cpu_microbenchmark aggressor_long_cpu_microbenchmark.c long_prime_number_factorization.c 
