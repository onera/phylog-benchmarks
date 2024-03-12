// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include "general_include.h"
#include "interference_functions.h"

int tint[SIZE];
long tlong[SIZE];

// ----------------------------------------
// Victim version of the Load MicroBenchmark with additive stride
// ----------------------------------------
int main(int argc, char **argv)
{
  for (int j = 0; j < SIZE; j++) tlong[j] = 0;

  // ----------------------------------------
  //    Parameters display
  // ----------------------------------------
  printf("# ------------------------------------------------------------\n");
  printf("# Name : victim_add_load_microbenchmark \n");
  printf("# Description: reads an array of long integers using an increasing value of stride\n");
  printf("# Stride values: ");
  for (int stride = 1; stride <= STRIDE_MAX; stride *= 2) printf (" %d",stride);
  printf("\n");
  printf("# Data type: long  size: %ld bytes\n", sizeof(long));
  printf("# Number of measurements: %d for each value of stride\n", REPEAT);
  printf("# ------------------------------------------------------------\n");

  // ----------------------------------------
  // Measurement loop
  // ----------------------------------------
  for (int stride = 1; stride <= STRIDE_MAX; stride *= 2) {
    int repeat = REPEAT ;
    do {
      // Loop to clean the cache
      for (int j = 0; j < SIZE; j++) tint[j] = 0;

      load_with_add_stride (tlong, SIZE, stride, VICTIM);
    } while (--repeat > 0);

  } // end for stride

  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_add_load_microbenchmark victim_add_load_microbenchmark.c load_with_add_stride.c
