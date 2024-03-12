// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"

// ----------------------------------------
// Victim version of the long-integer CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name: victim_long_cpu_microbenchmark (prime number factorization)\n");
  printf("# Data type: long size: %ld bytes\n", sizeof(long));
  printf("# Number of measurements %d\n", REPEAT);
  printf("# Value to be factorized: %d\n", VALUE_TO_FACTORIZE);
  printf("# ------------------------------------------------------------\n");
  
  // ----------------------------------------
  //   Starting loop to clean the resources 
  // ----------------------------------------
  long_prime_number_factorization (0, AGGRESSOR) ; 
  
  // ----------------------------------------
  //    Measurement loop
  // ----------------------------------------
  int repeat = REPEAT;
  do {
    long_prime_number_factorization (REPEAT-repeat, VICTIM) ; 
  } while (--repeat > 0);
  
  return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_long_cpu_microbenchmark victim_long_cpu_microbenchmark.c long_prime_number_factorization.c 

