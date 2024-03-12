// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"

int tint[SIZE];
long tpt[SIZE];

// ----------------------------------------
// Victim version of the load microbenchmark with deterministic index chasing
// ----------------------------------------
int main(int argc, char **argv)
{
  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name : victim_deterministic_index_chasing_load_microbenchmark \n");
  printf("# Description: reads an array of long integers using the index chasing method (tpt[i] contains the index of the next element to read)\n");
  printf("# Stride values: ");
  for (int stride = 1; stride <= STRIDE_MAX; stride *= 2) printf (" %d",stride);
  printf("\n");
  printf("# Data type: long  size: %ld bytes\n", sizeof(long));
  printf("# Number of measurements: %d for each value of stride\n", REPEAT);
  printf("# ------------------------------------------------------------\n");

  for (int stride = 1; stride <= STRIDE_MAX; stride *= 2) {
    int repeat = REPEAT;
    
    // ----------------------------------------
    // Measurement loop
    // ----------------------------------------
    do {
      // Initialisation of the tpt ring for the given value of stride
      for (int i = 0; i < stride; i++) {
	for (int j = i; j < SIZE; j = j + stride)
	  if (j + stride < SIZE) tpt[j] = j + stride;
	  else tpt[j] = i + 1;
      }
	
      // pointer verification
      for (int i = 0; i < SIZE; i++)
	assert((tpt[i] >= 0 && (tpt[i] < SIZE)));
      
      // Starting loop to clean the resources 
      for (int j = 0; j < SIZE; j++) tint[j] = 0;
      
      load_with_index_chasing (tpt, SIZE, stride, VICTIM);
  
    } while (--repeat > 0);

  } // end for stride
  
  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_deterministic_index_chasing_load_microbenchmark victim_deterministic_index_chasing_load_microbenchmark.c load_with_index_chasing.c
