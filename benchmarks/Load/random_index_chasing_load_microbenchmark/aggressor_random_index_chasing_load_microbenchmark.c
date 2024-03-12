// ----------------------------------------
// Benchmark parameters
// ----------------------------------------
#include "parameters.h"

// ----------------------------------------
#include <math.h>
#include "general_include.h"
#include "interference_functions.h"

int tint[SIZE];
long tpt[SIZE];

// ----------------------------------------
// Aggressor version of the load microbenchmark with randomized index chasing
// ----------------------------------------
int main (int argc, char **argv)
{
  // Parameter = value of the radius of the random area
  int  radius = atoi(argv[1]);

  // ----------------------------------------
  // Initialization of the ring tpt
  // ----------------------------------------
  for (int i = 0; i < SIZE; i = i + 1) tpt[i] = (i + 1) % SIZE;
  
  // ----------------------------------------
  // Mixing the ring tpt :
  // one takes a random i_rand, and a random j_rand within a 
  // increasing radius around i_rand 
  // and one chnage i_rand and j_rand in the ring
  // ----------------------------------------
  long i_rand, j_rand, x, y, z;
  long cpt = 0;
  srand (512);
  int repeatCt = 3;
  for (int r = 0; r < repeatCt; r++)
    {
      for (int i = 0; i < SIZE - radius; i = i + radius)
	{
	  for (int j = 0; j < radius; j++)
	    {
	      i_rand = i + rand () % radius;
	      j_rand = i + rand () % (radius);
	      x = tpt[i_rand];
	      y = tpt[j_rand];
	      z = tpt[y];
	      
	      if ((i_rand != j_rand) && (i_rand != y) && (x != y))
		{
		  tpt[i_rand] = y;
		  tpt[j_rand] = z;
		  tpt[y] = x;
		  cpt++;
		} // end if 
	    } // end for j 
	} // end for i 
    } // end for r 
  
  // Check tpt is again a ring
  int cycle_lg = 0;
  long pti = 0;
  do
    {
      assert ((tpt[pti] >= 0 && (tpt[pti] < SIZE)));
      pti = tpt[pti];
      cycle_lg++;
    }
  while ((pti != 0) && (cycle_lg < SIZE));
  assert (cycle_lg == SIZE);
  
  // Compute the average value of stride in tpt
  float average_stride = 0.;
  for (int i = 0; i < SIZE; i++)
    average_stride = labs (tpt[i] - i) + average_stride;
  average_stride = average_stride / SIZE;  
  
  // ----------------------------------------
  // Agressive loop
  // ----------------------------------------
  while (1) {      
    load_with_index_chasing (tpt, SIZE, (int)average_stride, AGGRESSOR);
  }
  
  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o aggressor_random_index_chasing_load_microbenchmark aggressor_random_index_chasing_load_microbenchmark.c load_with_index_chasing.c
