// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"


// ----------------------------------------
// Victim version of the double precision CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name: victim_double_cpu_microbenchmark (pi_computation)\n");
  printf("# Data type: double size: %ld bytes\n", sizeof(double));
  printf("# Description: compute the value of Pi using the iterative formula pi/4 ~ sum_{i = 0 to N} (-1)^i/(2i+1)\n");
  printf("# Iteration depth : N=%d\n", PI_COMPUTATION_DEPTH);
  printf("# Number of measurements (i.e., the number of times Pi is computed): %d\n", REPEAT);
  printf("# ------------------------------------------------------------\n");
  
  // ----------------------------------------
  //   Starting loop to clean the resources 
  // ----------------------------------------
  double_pi_computation (0, AGGRESSOR) ;
  
  // ----------------------------------------
  //    Measurement loop 
  // ----------------------------------------
  int repeat = REPEAT;
  do {
    double_pi_computation (REPEAT-repeat, VICTIM) ;
  } while (--repeat > 0);
  
  return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_double_cpu_microbenchmark victim_double_cpu_microbenchmark.c double_pi_computation.c 
