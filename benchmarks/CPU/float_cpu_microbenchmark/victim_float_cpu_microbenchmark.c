// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"


// ----------------------------------------
// Victim version of the float CPU microbenchmark
// ----------------------------------------
int main( int argc, char ** argv )
{
  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name: victim_float_cpu_microbenchmark (pi_computation)\n");
  printf("# Data type: float size: %ld bytes\n", sizeof(float));
  printf("# Description: compute the value of Pi using the iterative formula pi/4 ~ sum_{i = 0 to N} (-1)^i/(2i+1)\n");
  printf("# Iteration depth : N=%d\n", PI_COMPUTATION_DEPTH);
  printf("# Number of measurements (i.e., the number of times Pi is computed): %d\n", REPEAT);
  printf("# ------------------------------------------------------------\n");
  
  // ----------------------------------------
  //   Starting loop to clean the resources 
  // ----------------------------------------
  float_pi_computation (0, AGGRESSOR) ;
  
  // ----------------------------------------
  //    Measurement loop 
  // ----------------------------------------
  int repeat = REPEAT;
  do {  
    float_pi_computation (REPEAT-repeat, VICTIM) ;
  } while (--repeat > 0);
  
  return 0;
}

// To be compiled by 
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_float_cpu_microbenchmark victim_float_cpu_microbenchmark.c float_pi_computation.c 

