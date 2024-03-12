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
 // Aggressor version of the load microbenchmark with deterministic index chasing
 // ----------------------------------------
 // parameter = stride
 // ----------------------------------------
 
int main( int argc, char ** argv )
{
  // parameter = value of stride
  int  stride = atoi(argv[1]);

  // ----------------------------------------
  // Initialization of tpt using the index chasing principle
  // ----------------------------------------
  for (int i = 0; i < stride; i++)
    {
      for (int j = i; j < SIZE; j = j + stride)
        {
          if (j + stride < SIZE) tpt[j] = j + stride;
          else tpt[j] = i + 1;
        }
    }
  
  // ----------------------------------------
  // Agressive loop
  // ----------------------------------------
  while (1) {       
      load_with_index_chasing (tpt, SIZE, stride, AGGRESSOR);
    }
  
  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_deterministic_index_chasing_load_microbenchmark aggressor_deterministic_index_chasing_load_microbenchmark.c load_with_index_chasing.c
