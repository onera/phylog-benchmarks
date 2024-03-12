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
// Victim version of the load microbenchmark with randomized index chasing
// ----------------------------------------
int main (int argc, char **argv)
{
  for (int radius = 5; radius < 10000; radius = radius + 100)
    {
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
      for (int r = 0; r < repeatCt; r++) {
	for (int i = 0; i < SIZE - radius; i = i + radius) {
	  for (int j = 0; j < radius; j++) {
	    i_rand = i + rand () % radius;
	    j_rand = i + rand () % (radius);
	    x = tpt[i_rand];
	    y = tpt[j_rand];
	    z = tpt[y];
	    
	    if ((i_rand != j_rand) && (i_rand != y) && (x != y)) {
	      tpt[i_rand] = y;
	      tpt[j_rand] = z;
	      tpt[y] = x;
	      cpt++;
	    } // end if 
	  } // end for j 
	} // end fir i 
      } //end for r 
      
      // Check tpt is again a ring
      int cycle_lg = 0;
      long pti = 0;
      do {
	assert ((tpt[pti] >= 0 && (tpt[pti] < SIZE)));
	pti = tpt[pti];
	cycle_lg++;
      } while ((pti != 0) && (cycle_lg < SIZE));
      assert (cycle_lg == SIZE);

      // Compute the average value stride in tpt
      float average_stride = 0.;
      for (int i = 0; i < SIZE; i++) average_stride = labs (tpt[i] - i) + average_stride;
      average_stride = average_stride / SIZE;
      // Compute the variance value of stride in tpt
      double variance_stride = 0.;
      for (int i = 0; i < SIZE; i++)
	variance_stride =
	  (labs (tpt[i] - i) - average_stride) * (labs (tpt[i] - i) - average_stride) +
	  variance_stride;
      variance_stride = variance_stride / SIZE;

      // ----------------------------------------
      //    Parameters display
      // ----------------------------------------
      printf ("# ------------------------------------------------------------\n");
      printf ("# Name: victim_random_index_chasing_load_microbenchmark \n");
      printf ("# Description: index chasing load with a random stride \n");
      printf ("# Data type: pointer to long  size: %ld bytes\n", sizeof(long *));
      printf ("# Number of measurements: %d for each value of stride\n", REPEAT);
      printf ("# Average stride = %f (in number of long integer) with radius = %d\n", average_stride, radius);
      printf ("# Variance = %lf (en nb d'entiers longs) \n", variance_stride);
      printf ("# ------------------------------------------------------------\n");

      // ----------------------------------------
      // Measurement loop
      // ----------------------------------------
      int repeat = REPEAT;
      do {
	// boucle raz du cache
	for (int j = 0; j < SIZE; j++) tint[j] = 0;
	
	load_with_index_chasing (tpt, SIZE, (int)average_stride, VICTIM);
      } while (--repeat > 0);

    } // end for int radius
  return 0;
}

// To be compiled by
// gcc -I../../../include -Wall -std=c99 -pedantic -O0 -o victim_random_index_chasing_load_microbenchmark victim_random_index_chasing_load_microbenchmark.c load_with_index_chasing.c
