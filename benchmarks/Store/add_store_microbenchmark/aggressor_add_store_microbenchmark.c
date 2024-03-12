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
// Aggressor version of the Store MicroBenchmark with additive stride
// ----------------------------------------
int main(int argc, char **argv)
{
  // Parameter = value of stride
  int  stride = atoi(argv[1]);
  
  // ----------------------------------------
  // Agressive loop
  // ----------------------------------------
  while (1) {
      store_with_add_stride (tlong, SIZE, stride, AGGRESSOR);
    }
  
  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_add_store_microbenchmark aggressor_add_store_microbenchmark.c store_with_add_stride.c
