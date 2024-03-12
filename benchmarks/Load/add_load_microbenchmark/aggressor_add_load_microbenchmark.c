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
// Aggressor version of the Load MicroBenchmark with additive stride
// ----------------------------------------
int main(int argc, char **argv)
{
  // Parameter = value of stride
  int  stride = atoi(argv[1]);
  for (int j = 0; j < SIZE; j++) tlong[j] = 0;

  // ----------------------------------------
  // Agressive loop
  // ----------------------------------------
  while (1) {
    load_with_add_stride (tlong, SIZE, stride, AGGRESSOR);
  }

  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_add_load_microbenchmark aggressor_add_load_microbenchmark.c load_with_add_stride.c
