// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"

// ----------------------------------------
// Victim version of the interger CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name: victim_int_cpu_microbenchmark (primer number factorization)\n");
  printf("# Data type: int, size: %ld bytes\n", sizeof(int));
  printf("# Number of measurements %d\n", REPEAT);
  printf("# Value to be factorized: %d\n", VALUE_TO_FACTORIZE);
  printf("# ------------------------------------------------------------\n");
  
  // ----------------------------------------
  //   Starting loop to clean the resources 
  // ----------------------------------------
  int_prime_number_factorization (0, AGGRESSOR) ; 

  // ----------------------------------------
  //    Measurement loop
  // ----------------------------------------
  int repeat = REPEAT;
  do {
    int_prime_number_factorization (REPEAT-repeat, VICTIM) ; 
  } while (--repeat > 0);
  
  return 0;
}

// to be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_int_cpu_microbenchmark victim_int_cpu_microbenchmark.c int_prime_number_factorization.c 

